return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          projects = {
            -- same projects as <leader>fP (see lua/config/projects.lua),
            -- on top of the git roots of recently opened files
            dev = {},
            projects = require("config.projects").list(),
          },
        },
      },
    },
  },
}
