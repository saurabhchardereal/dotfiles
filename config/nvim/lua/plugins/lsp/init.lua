return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP, Formatters, DAP installer
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
          require("mason").setup({
            ui = {
              border = "rounded",
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
              },
            },
          })

          local ensure_installed = {
            -- lsp
            "css-lsp",
            "cssmodules-language-server",
            "dockerfile-language-server",
            "emmet-ls",
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "tailwindcss-language-server",
            "typescript-language-server",
            -- "vtsls",
            "yaml-language-server",

            -- formatters
            "eslint_d",
            "prettierd",
          }

          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
          end, {})
        end,
      },

      -- Neovim API completions
      {
        "folke/neodev.nvim",
        opts = { library = { plugins = false } },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local handlers = require("plugins.lsp.handlers")
      local diagnostics = require("plugins.lsp.diagnostics")
      local lsp_autocmds = require("plugins.lsp.autocmds")
      local lsp_formatting = require("plugins.lsp.formatting")
      local lsp_mappings = require("plugins.lsp.mappings")

      -- List of servers to setup
      local NIL = {} -- to avoid creating a new unique table every time
      local servers = {
        cssls = NIL,
        cssmodules_ls = require("plugins.lsp.servers.cssmodules_ls"),
        dockerls = NIL,
        emmet_ls = require("plugins.lsp.servers.emmet_ls"),
        html = NIL,
        jsonls = require("plugins.lsp.servers.jsonls"),
        lua_ls = require("plugins.lsp.servers.lua_ls"),
        tailwindcss = require("plugins.lsp.servers.tailwindcss"),
        yamlls = NIL,
      }

      -- Setup handlers and diagnostics config
      handlers.setup()
      diagnostics.setup()

      -- Update capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion =
        { completionItem = { snippetSupport = true } }

      -- Attach callbacks
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("LspAttach", {
        group = lsp_autocmds.lsp_augroup_id,
        callback = function(args)
          -- Clear any autocmd declared by previous client
          -- TODO: file an issue upstream with repro
          if
            pcall(
              vim.api.nvim_get_autocmds,
              { group = lsp_autocmds.lsp_augroup_id, buffer = args.buf }
            )
          then
            vim.api.nvim_clear_autocmds({
              group = lsp_autocmds.lsp_augroup_id,
              buffer = args.buf,
            })
          end

          -- TODO: Temporarily disable semantic tokens
          vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider =
            nil

          lsp_autocmds.attach(args)
          lsp_formatting.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      -- Setup all listed servers
      for lsp, server in pairs(servers) do
        lspconfig[lsp].setup(vim.tbl_deep_extend("force", server.config or {}, {
          capabilities = capabilities,
        }))
      end
    end,
  },

  -- Typescript helper commands
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = { "nvim-lspconfig" },
    opts = {
      debug = false,
    },
  },
}