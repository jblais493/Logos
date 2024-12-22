return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Your existing servers
        "lua-language-server",
        "stylua",
        "gopls",
        "templ",
        "sql",
        
        -- Svelte and web development
        "svelte-language-server",
        "typescript-language-server",
        "emmet-ls",
        "prettier",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",

        -- Additional recommended servers for your stack
        "eslint-lsp",           -- JavaScript/TypeScript linting
        "json-lsp",             -- JSON support
        "stylelint-lsp",        -- CSS/SCSS linting
        "deno",                 -- Alternative JS/TS runtime
      },
    },
  },
}
