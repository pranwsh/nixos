{
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    luaConfigRC.inline-completion = ''
      local ns_id = vim.api.nvim_create_namespace('inline_ai')
      local timer = nil
      local current_suggestion = nil
      local last_request_id = 0 -- Track the latest request

      local function clear_suggestion()
        if current_suggestion then
          pcall(vim.api.nvim_buf_del_extmark, 0, ns_id, current_suggestion)
          current_suggestion = nil
        end
      end

      local function get_completion()
        local bufnr = vim.api.nvim_get_current_buf()

        -- 1. Increment ID to "cancel" any previous pending requests
        last_request_id = last_request_id + 1
        local request_id = last_request_id

        -- Get context
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line_idx = cursor[1] - 1
        local col_idx = cursor[2]

        local lines = vim.api.nvim_buf_get_lines(bufnr, math.max(0, line_idx - 30), line_idx + 1, false)
        if #lines == 0 then return end
        lines[#lines] = lines[#lines]:sub(1, col_idx)
        local prompt = table.concat(lines, "\n")

        local curl = require('plenary.curl')
        curl.post('http://127.0.0.1:8080/v1/completions', {
          headers = { ['Content-Type'] = 'application/json' },
          body = vim.json.encode({
            model = 'qwen',
            prompt = prompt,
            max_tokens = 50,
            temperature = 0,
            stop = { "\n", "<|endoftext|>", "<|im_end|>" },
          }),
          callback = vim.schedule_wrap(function(response)
            -- 2. Check if this response is still the one we want
            if request_id ~= last_request_id then return end

            -- 3. Check if we are still in Insert mode
            local mode = vim.api.nvim_get_mode().mode
            if mode ~= 'i' then return end

            if response.status == 200 then
              local data = vim.json.decode(response.body)
              local completion = data.choices[1].text

              if completion and #completion > 0 then
                -- 4. Get FRESH coordinates to avoid "out of range" errors
                local cur = vim.api.nvim_win_get_cursor(0)
                local cur_line = cur[1] - 1
                local cur_col = cur[2]

                clear_suggestion()
                -- Use 'inline' instead of 'overlay' for better UX
                current_suggestion = vim.api.nvim_buf_set_extmark(bufnr, ns_id, cur_line, cur_col, {
                  virt_text = {{completion, 'Comment'}},
                  virt_text_pos = 'inline',
                })
              end
            end
          end)
        })
      end

      -- Keymaps: Using nvim_put is cleaner than string concatenation
      local function accept_suggestion()
        if current_suggestion then
          local mark = vim.api.nvim_buf_get_extmark_by_id(0, ns_id, current_suggestion, {details = true})
          if mark and mark[3] and mark[3].virt_text then
            local text = mark[3].virt_text[1][1]
            clear_suggestion()
            vim.api.nvim_put({text}, 'c', false, true)
          end
        end
      end

      -- Autocmds
      vim.api.nvim_create_autocmd({'TextChangedI', 'InsertLeave'}, {
        callback = function(ev)
          clear_suggestion() -- Clear immediately when typing
          if ev.event == 'InsertLeave' then
            last_request_id = last_request_id + 1 -- Invalidate pending on exit
            return
          end

          if timer then timer:stop() end
          timer = vim.defer_fn(get_completion, 400) -- Slightly longer debounce for stability
        end,
      })

      vim.keymap.set('i', '<C-Tab>', function()
        if current_suggestion then
          accept_suggestion()
          return ""
        else
          return "<Tab>"
        end
      end, { expr = true })

      vim.keymap.set('i', '<C-e>', clear_suggestion)
    '';
  };
}
