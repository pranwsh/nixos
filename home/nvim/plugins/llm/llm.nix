{
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    luaConfigRC.inline-completion = ''
      -- Simple inline AI completion with FIM support
      local ns_id = vim.api.nvim_create_namespace('inline_ai')
      local timer = nil
      local current_suggestion = nil

      local function clear_suggestion()
        if current_suggestion then
          vim.api.nvim_buf_del_extmark(0, ns_id, current_suggestion)
          current_suggestion = nil
        end
      end

      local function get_completion()
        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line_idx = cursor[1] - 1
        local col_idx = cursor[2]

        -- Get Prefix (before cursor) and Suffix (after cursor)
        local before_lines = vim.api.nvim_buf_get_lines(bufnr, math.max(0, line_idx - 50), line_idx + 1, false)
        before_lines[#before_lines] = before_lines[#before_lines]:sub(1, col_idx)

        local after_lines = vim.api.nvim_buf_get_lines(bufnr, line_idx, line_idx + 50, false)
        after_lines[1] = after_lines[1]:sub(col_idx + 1)

        local prefix = table.concat(before_lines, "\n")
        local suffix = table.concat(after_lines, "\n")

        -- Qwen 2.5 FIM Format
        local prompt = string.format("<|fim_prefix|>%s<|fim_suffix|>%s<|fim_middle|>", prefix, suffix)

        local curl = require('plenary.curl')
        curl.post('http://127.0.0.1:8080/v1/completions', {
          headers = { ['Content-Type'] = 'application/json' },
          body = vim.json.encode({
            model = 'qwen',
            prompt = prompt,
            max_tokens = 60,
            temperature = 0, -- 0 is better for autocomplete consistency
            stop = { "<|file_sep|>", "<|fim_prefix|>", "<|fim_suffix|>", "<|fim_middle|>", "\n" },
          }),
          callback = vim.schedule_wrap(function(response)
            if response.status == 200 then
              local data = vim.json.decode(response.body)
              local completion = data.choices[1].text
              if completion and #completion > 0 then
                clear_suggestion()
                current_suggestion = vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_idx, col_idx, {
                  virt_text = {{completion, 'Comment'}},
                  virt_text_pos = 'inline', -- Changed from 'overlay'
                  hl_mode = 'combine',
                })
              end
            end
          end)
        })
      end

      -- Accept/Trigger logic (your existing logic is good)
      local function accept_suggestion()
        if current_suggestion then
          local mark = vim.api.nvim_buf_get_extmark_by_id(0, ns_id, current_suggestion, {details = true})
          if mark and mark[3] and mark[3].virt_text then
            local text = mark[3].virt_text[1][1]
            local cursor = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_put({text}, 'c', false, true)
            clear_suggestion()
          end
        end
      end

      vim.api.nvim_create_autocmd({'TextChangedI'}, {
        callback = function()
          clear_suggestion()
          if timer then timer:stop() end
          timer = vim.defer_fn(get_completion, 250)
        end,
      })

      vim.keymap.set('i', '<Tab>', function()
        if current_suggestion then
          accept_suggestion()
          return ""
        else
          return "<Tab>"
        end
      end, { expr = true })
    '';
  };
}
