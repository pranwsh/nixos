{
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    luaConfigRC.inline-completion = ''
      -- Simple inline AI completion
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
        local line = cursor[1] - 1
        local col = cursor[2]

        -- Get context
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line + 1, false)
        local current_line = lines[#lines]
        local prefix = current_line:sub(1, col)

        -- Build prompt
        local context = table.concat(lines, "\n")
        local prompt = context

        -- Call API
        local curl = require('plenary.curl')
        curl.post('http://127.0.0.1:8080/v1/completions', {
          headers = {
            ['Content-Type'] = 'application/json',
          },
          body = vim.json.encode({
            model = 'qwen',
            prompt = prompt,
            max_tokens = 50,
            temperature = 0.2,
            stop = { "\n", "<|endoftext|>", "<|im_end|>" },
          }),
          callback = vim.schedule_wrap(function(response)
            if response.status == 200 then
              local data = vim.json.decode(response.body)
              local completion = data.choices[1].text

              if completion and #completion > 0 then
                clear_suggestion()
                current_suggestion = vim.api.nvim_buf_set_extmark(bufnr, ns_id, line, col, {
                  virt_text = {{completion, 'Comment'}},
                  virt_text_pos = 'overlay',
                  hl_mode = 'combine',
                })
              end
            end
          end)
        })
      end

      local function accept_suggestion()
        if current_suggestion then
          local mark = vim.api.nvim_buf_get_extmark_by_id(0, ns_id, current_suggestion, {details = true})
          if mark and mark[3] and mark[3].virt_text then
            local text = mark[3].virt_text[1][1]
            local cursor = vim.api.nvim_win_get_cursor(0)
            local line = vim.api.nvim_get_current_line()
            local new_line = line:sub(1, cursor[2]) .. text .. line:sub(cursor[2] + 1)
            vim.api.nvim_set_current_line(new_line)
            vim.api.nvim_win_set_cursor(0, {cursor[1], cursor[2] + #text})
          end
          clear_suggestion()
        end
      end

      -- Auto-trigger on text change
      vim.api.nvim_create_autocmd({'TextChangedI', 'CursorMovedI'}, {
        callback = function()
          clear_suggestion()
          if timer then
            timer:stop()
          end
          timer = vim.defer_fn(function()
            get_completion()
          end, 300)
        end,
      })

      -- Keymaps
      vim.keymap.set('i', '<Tab>', function()
        if current_suggestion then
          accept_suggestion()
        else
          return '<Tab>'
        end
      end, { expr = true })

      vim.keymap.set('i', '<C-e>', clear_suggestion)
    '';
  };
}
