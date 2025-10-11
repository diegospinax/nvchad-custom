local M = {}

function M:setup()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = "/home/diegospinax/development/jdtls_data/" .. project_name
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      -- 💀
      "/home/diegospinax/.sdkman/candidates/java/current/bin/java", -- or '/path/to/java17_or_newer/bin/java'
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx4g", -- Increase this (default is often 1g)
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",

      "-javaagent:" .. vim.fn.expand("~/.local/share/nvim/lombok.jar"),

      -- 💀
      "-jar",
      "/home/diegospinax/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",

      -- 💀
      "-configuration",
      "/home/diegospinax/.local/share/nvim/mason/packages/jdtls/config_linux",

      -- 💀
      -- See `data directory configuration` section in the README
      "-data",
      workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

    -- ... (parte de la configuración de jdtls)
    on_attach = function(client, bufnr)
      -- Llama a la función on_attach original de NvChad para mantener sus atajos
      require("nvchad.configs.lspconfig").on_attach(client, bufnr)
      -- NUESTRO ATAJO: Organizar Imports con Ctrl + o
      vim.keymap.set("n", "<C-o>", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
      end, { buffer = bufnr, desc = "LSP: Organize Imports" })
    end,
    -- ... (resto de la configuración)

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        semanticHighlighting = {
          enabled = true, -- or false to disable
        },
        jdt = {
          ls = {
            lombokSupport = {
              enabled = true,
            },
          },
        },
      },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {},
    },
  }
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  require("jdtls").start_or_attach(config)
end

return M
