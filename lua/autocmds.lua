require("nvchad.autocmds")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("jdtls.jdlts_setup").setup()
  end,
})
