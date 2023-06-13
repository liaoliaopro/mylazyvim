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
          require("lazyvim.util").on_attach(function(client, buffer)
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

          vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Crate Version(rust)" })
          vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Crate Features(rust)" })
          vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Crate Dependencies(rust)" })
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
}
