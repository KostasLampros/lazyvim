return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        hidden = true,
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        },
      },
    },
    keys = {
      {
        "<leader>fP",
        function()
          local base_dirs = { "~/Documents/azkaban", "~/Documents/migration", "~/.config" }
          require("telescope.builtin").find_files({
            prompt_title = "Switch Project",
            cwd = vim.fn.expand("~"),
            search_dirs = base_dirs,
            find_command = { "fd", "--type", "d", "--max-depth", "1" },
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("cd " .. selection.path)
                vim.cmd("Neotree close")
                vim.cmd("Neotree reveal")
                print("Switched to: " .. selection.path)
              end)
              return true
            end,
          })
        end,
        desc = "Switch Project (base dirs)",
      },
    },
  },
}
