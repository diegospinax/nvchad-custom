return {
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "xml",
      "javascriptreact", -- Only JSX files
      "typescriptreact", -- Only TSX files
      "svelte",
      "vue",
      "markdown",
    },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        -- Only auto-close in specific Treesitter nodes (JSX/TSX elements, not generics)
        per_filetype = {
          ["html"] = {
            enable_close = true,
          },
          ["javascriptreact"] = {
            enable_close = true,
          },
          ["typescriptreact"] = {
            enable_close = true,
          },
        },
      })
    end,
  },
}
