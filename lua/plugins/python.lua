return {
  -- Python debugging support with DAP
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- Setup debugpy - Mason will install it to this path
      local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
      local python_path = vim.fn.filereadable(mason_path) == 1 and mason_path or "python3"
      require("dap-python").setup(python_path)

      -- Configure test runner
      require("dap-python").test_runner = "pytest"
    end,
  },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",
    branch = "regexp",
    opts = {
      -- Optional: you can customize the plugin here
      -- search = {},
      -- options = {}
    },
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
    },
  },
}
