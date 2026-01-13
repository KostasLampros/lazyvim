return {
  --add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  --add tokyonight
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },

  --Configure colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "gruvbox",
      colorscheme = "tokyonight-night",
      --colorscheme = "tokyonight-storm",
      --colorscheme = "tokyonight-day",
      --colorscheme = "tokyonight-moon",
    },
  },
}
