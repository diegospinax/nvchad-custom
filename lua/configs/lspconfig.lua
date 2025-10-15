require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "omnisharp", "ts_ls", "eslint", "tailwindcss", "pyright", "dockerls", "yaml" }
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

local function organize_imports()
  local clients = vim.lsp.get_clients({ bufnr = 0, name = 'ts_ls' })
  if clients[1] then
    clients[1]:exec_cmd({
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = "Organize Imports"
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ts_ls' then
      vim.keymap.set('n', '<leader>oi', organize_imports, { buffer = args.buf, desc = 'Organize Imports' })
    end
  end,
})
