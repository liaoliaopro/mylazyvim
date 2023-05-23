return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        -- nls.builtins.formatting.ruff,
        nls.builtins.formatting.black,
        -- nls.builtins.diagnostics.ruff,
      })
      nls.builtins.formatting.black.with({
        extra_args = { "--line-length=88" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                flake8 = { enabled = false },
                autopep8 = { enabled = false },
                black = { enabled = true },
                ruff = {
                  enabled = true,
                  extendSelect = { "I" },
                },
                mypy = {
                  enabled = true,
                  live_mode = true,
                  strict = true,
                },
              },
            },
          },
        },
      },
    },
  },

  --[[
  -- disable pyright
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
      setup = {
        pyright = function(_, _)
          -- FIXME disable pyright hints. Someday when ruff-lsp can do completion
          -- pyright can be removed.
          -- client.handlers["textDocument/publishDiagnostics"] = function(...) end
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          local util = require("lspconfig.util")
          util.default_config = vim.tbl_extend("force", util.default_config, {
            capabilities = capabilities,
          })

          local lsp_utils = require("plugins.lsp.utils")
          lsp_utils.on_attach(function(client, buffer)

            -- stylua: ignore
            if client.name == "pyright" then
              vim.keymap.set("n", "<leader>tC", function() require("dap-python").test_class() end, { buffer = buffer, desc = "Debug Class" })
              vim.keymap.set("n", "<leader>tM", function() require("dap-python").test_method() end, { buffer = buffer, desc = "Debug Method" })
              vim.keymap.set("v", "<leader>tS", function() require("dap-python").debug_selection({}) end, { buffer = buffer, desc = "Debug Selection" })
            end
          end)
        end,
      },
    },
  },
  ]]
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    opts = {
      setup = {
        debugpy = function(_, _)
          require("dap-python").setup("python", {})
          table.insert(require("dap").configurations.python, {
            type = "python",
            request = "attach",
            connect = {
              port = 5678,
              host = "127.0.0.1",
            },
            mode = "remote",
            name = "container attach debug",
            cwd = vim.fn.getcwd(),
            pathmappings = {
              {
                localroot = function()
                  return vim.fn.input({
                    prompt = "local code folder > ",
                    default = vim.fn.getcwd(),
                    completion = "file",
                  })
                end,
                remoteroot = function()
                  return vim.fn.input({ prompt = "container code folder > ", default = "/", completion = "file" })
                end,
              },
            },
          })
        end,
      },
    },
  },
}
