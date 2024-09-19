return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      local luasnip = require("luasnip")
      
      -- Load default NvChad snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load custom snippets
      require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
      
      luasnip.config.set_config(opts)

      -- Extend .templ files to use HTML snippets
      luasnip.filetype_extend("templ", {"html"})
      
      -- Optional: Add .templ to the list of file types that trigger HTML LSP
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "templ",
        callback = function()
          local client = vim.lsp.start({
            name = "html-lsp",
            cmd = {"vscode-html-language-server", "--stdio"},
            root_dir = vim.fn.getcwd(),
          })
          if not client then
            vim.notify("Failed to start HTML LSP for templ file", vim.log.levels.WARN)
          end
        end,
      })

      -- Unlink snippets when leaving insert mode
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
              and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end,
      })
    end,
  }
}
