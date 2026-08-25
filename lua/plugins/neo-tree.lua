return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false, -- show filtered items (dotfiles etc.) by default, greyed out
          hide_dotfiles = false, -- don't hide dotfiles
          hide_gitignored = true, -- still hide gitignored files (optional, your call)
          hide_by_name = {
            ".git",
            ".DS_Store",
            "node_modules",
            -- add any other names you want hidden completely
          },
          never_show = {
            ".git", -- these never show even if you toggle visibility
          },
        },
      },
    },
  },
}
