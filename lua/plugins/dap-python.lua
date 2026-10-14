return {
  {
    "mfussenegger/nvim-dap-python",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Stop",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
    },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3"
      require("dap-python").setup(path)

      local dap = require("dap")
      local workspaceFolder = vim.fn.getcwd()

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "DATA producer",
          program = workspaceFolder .. "/test/test_producer.py",
          justMyCode = false,
          pythonPath = function()
            return path
          end,
          env = {
            PYTHONPATH = workspaceFolder
              .. "/code/python/producer:"
              .. workspaceFolder
              .. "/code/python:"
              .. workspaceFolder
              .. "/code/python/shared_library",
            ENVIRONMENT = "local",
            KAFKA_TOPIC = "test",
          },
        },
        {
          type = "python",
          request = "launch",
          name = "DATA consumer",
          program = workspaceFolder .. "/test/test_consumer.py",
          justMyCode = false,
          pythonPath = function()
            return path
          end,
          env = {
            PYTHONPATH = workspaceFolder
              .. "/code/python/consumer:"
              .. workspaceFolder
              .. "/code/python:"
              .. workspaceFolder
              .. "/code/python/shared_library",
            ENVIRONMENT = "local",
            LOG_LEVEL = "DEBUG",
            KAFKA_TOPIC = "test",
          },
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- remove LazyVim's default auto-close-on-exit listeners
      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil

      -- optional: keep UI open, don't auto-close at all
      dap.listeners.after.event_terminated["dapui_config"] = function()
        -- do nothing, keep UI open so you can inspect output/errors
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        -- do nothing
      end
    end,
  },
}
