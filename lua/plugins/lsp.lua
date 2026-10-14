return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = false, -- disable pylsp entirely
        -- pyright is configured in plugins/pyright.lua
        ruff = {
          init_options = {
            settings = {
              lineLength = 88,
              lint = {
                select = { "E", "F", "W", "I", "N", "UP", "B", "C4", "SIM" },
                ignore = { "E501" },
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
