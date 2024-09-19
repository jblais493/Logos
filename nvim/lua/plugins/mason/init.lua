return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua", "gopls", "templ", "sql",
        "html-lsp", "css-lsp", "prettier", "tailwindcss-language-server",
      },
    },
  }
}
