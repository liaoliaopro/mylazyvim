local install_root_dir = vim.fn.stdpath("data") .. "/mason"
local extension_path = install_root_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim", "rust-lang/rust.vim" },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              imports = { granularity = { group = "module" }, prefix = "self" },
              cargo = { allFeatures = true, buildScripts = { enable = true } },
              procMacro = { enable = true },
              checkOnSave = {
                command = "cargo clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local lsp_utils = require("plugins.lsp.utils")
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "rust_analyzer" then
              vim.keymap.set("n", "<leader>cR", "<cmd>RustRunnables<cr>", { buffer = buffer, desc = "Runnables" })
              vim.keymap.set("n", "<leader>cl", function() vim.lsp.codelens.run() end, { buffer = buffer, desc = "Code Lens" })
            end
          end)

          require("rust-tools").setup({
            tools = {
              hover_actions = { border = "solid" },
              on_initialized = function()
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                  pattern = { "*.rs" },
                  callback = function()
                    vim.lsp.codelens.refresh()
                  end,
                })
              end,
            },
            server = opts,
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          })
          return true
        end,
      },
    },
  },
  { -- extend auto completion
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        -- FIXME make keymap only work for Cargo.toml
        "Saecki/crates.nvim",
        event = { "BufEnter Cargo.toml" },
        -- event = { "BufRead Cargo.toml" },
        -- ft = { "Cargo.toml" },
        -- lazy = true,
        config = true,
        init = function()
          local crates = require("crates")

          vim.keymap.set(
            "n",
            "<leader>cv",
            crates.show_versions_popup,
            { desc = "Crate Version(rust)", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>cf",
            crates.show_features_popup,
            { desc = "Crate Features(rust)", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>cd",
            crates.show_dependencies_popup,
            { desc = "Crate Dependencies(rust)", buffer = bufnr }
          )

          -- vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle Crates", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload Crates", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", buffer = bufnr })
          -- vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update Crates", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Update All Crates", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { desc = "Upgrade Crate", buffer = bufnr })
          -- vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, { desc = "Update Crates", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, { desc = "Update All Crates", buffer = bufnr })
          --
          -- vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Open Homepage", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Open Repository", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cD", crates.open_documentation, { desc = "Open Documentation", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Open crates-io", buffer = bufnr })
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "crates", priority = 750 },
      }))
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local dap = require("dap")
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },

              -- On windows you may have to uncomment this:
              -- detached = false,
            },
          }
          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input({
                  prompt = "Path to executable: ",
                  default = vim.fn.getcwd() .. "/",
                  completion = "file",
                })
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }

          dap.configurations.c = dap.configurations.cpp
          dap.configurations.rust = dap.configurations.cpp
        end,
      },
    },
  },
}
