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
          -- every subdirectory of these is a project
          local parent_dirs = {
            "~/Documents/azkaban",
            "~/Documents/migration",
            "~/Documents/Projects/",
          }
          -- these directories are projects themselves
          local project_dirs = {
            "~/.config/zsh/",
            "~/.config/nvim/",
            "~/.config/kmonad/",
          }

          local projects = {}
          for _, parent in ipairs(parent_dirs) do
            parent = vim.fs.normalize(vim.fn.expand(parent))
            for name, type in vim.fs.dir(parent) do
              if type == "directory" then
                table.insert(projects, vim.fs.joinpath(parent, name))
              end
            end
          end
          for _, dir in ipairs(project_dirs) do
            table.insert(projects, vim.fs.normalize(vim.fn.expand(dir)))
          end

          require("telescope.builtin").find_files({
            prompt_title = "Switch Project",
            cwd = vim.fn.expand("~"),
            -- print the precomputed list instead of searching
            find_command = vim.list_extend({ "printf", "%s\\n" }, projects),
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if not selection then
                  return
                end
                local dir = vim.fn.fnamemodify(selection.path, ":p")

                -- save session for the project we're leaving
                local has_persistence, persistence = pcall(require, "persistence")
                if has_persistence then
                  persistence.save()
                end

                vim.cmd("Neotree close")

                -- close terminals belonging to the old project
                for _, term in ipairs(Snacks.terminal.list()) do
                  term:close()
                end

                -- close all old buffers (prompts if anything is unsaved)
                Snacks.bufdelete.all()

                -- switch cwd
                vim.fn.chdir(dir)

                -- restore the new project's session if one exists
                -- (load() already checks the branch session, then falls back to the plain one)
                if has_persistence then
                  persistence.load()
                  -- sessions may contain buffers from other projects; drop them
                  Snacks.bufdelete.delete({
                    filter = function(b)
                      local name = vim.api.nvim_buf_get_name(b)
                      return vim.bo[b].buftype == "" and name ~= "" and not vim.startswith(name, dir)
                    end,
                  })
                end

                -- pass dir explicitly; otherwise neo-tree reuses its stored root from the old project.
                -- deferred past neo-tree's 100ms follow-file debounce, which the session load triggers;
                -- running both at once makes the follow render into a missing window
                vim.defer_fn(function()
                  require("neo-tree.command").execute({ action = "show", dir = dir, reveal = true })
                end, 200)
                print("Switched to: " .. dir)
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
