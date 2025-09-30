return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          "jdtls",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls"
  },

}
