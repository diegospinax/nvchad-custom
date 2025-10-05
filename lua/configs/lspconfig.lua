require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "omnisharp", "ts_ls", "eslint", "tailwindcss", "pyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

-- Override NvChad's diagnostic settings
vim.diagnostic.config({ virtual_text = false })

-- Make sure it stays disabled even after LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})
