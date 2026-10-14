return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          root_markers = { ".git" },
          settings = {
            python = {
              analysis = {
                extraPaths = {
                  "./code/python",
                },
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- analyze whole project, not just open files
              },
            },
          },
        },
      },
    },
  },
}
