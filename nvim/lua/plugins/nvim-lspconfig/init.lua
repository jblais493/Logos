return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Configure hover handler for floating window
      local handler = function(_, result, ctx, config)
        config = config or {
          border = "rounded",
          focusable = true,
          max_width = 80,
          max_height = 40,
        }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          config
        )
      end
      vim.lsp.handlers["textDocument/hover"] = handler

      -- Go
      lspconfig.gopls.setup({
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- Svelte
      lspconfig.svelte.setup({
        settings = {
          svelte = {
            plugin = {
              html = { completions = { enable = true, emmet = true } },
              svelte = { completions = { enable = true } },
              css = { completions = { enable = true } },
            },
          },
        },
      })
      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({})
      -- Tailwind
      lspconfig.tailwindcss.setup({
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "class=\"([^\"]*)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "class: \"([^\"]*)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })
      -- HTML
      lspconfig.html.setup({
        filetypes = { "html", "svelte" },
      })
      -- CSS
      lspconfig.cssls.setup({
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })
      -- Emmet
      lspconfig.emmet_ls.setup({
        filetypes = {
          "html", "css", "scss", "javascript",
          "javascriptreact", "typescript", 
          "typescriptreact", "svelte",
        },
      })
    end,
  }
}
