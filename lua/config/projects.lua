-- Project directories shared by <leader>fP and the dashboard's Projects picker
local M = {}

-- every subdirectory of these is a project
M.parent_dirs = {
  "~/Documents/azkaban",
  "~/Documents/migration",
  "~/Documents/Projects/",
}

-- these directories are projects themselves
M.project_dirs = {
  "~/.config/zsh/",
  "~/.config/nvim/",
  "~/.config/kmonad/",
}

--- Absolute paths of all projects
---@return string[]
function M.list()
  local projects = {}
  for _, parent in ipairs(M.parent_dirs) do
    parent = vim.fs.normalize(vim.fn.expand(parent))
    for name, type in vim.fs.dir(parent) do
      if type == "directory" then
        table.insert(projects, vim.fs.joinpath(parent, name))
      end
    end
  end
  for _, dir in ipairs(M.project_dirs) do
    table.insert(projects, vim.fs.normalize(vim.fn.expand(dir)))
  end
  return projects
end

return M
