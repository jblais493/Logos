return {
  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {
      window = {
        backdrop = 1,  -- Fully opaque
        width = 100,
        height = 0.85,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = true,
          font = "+4",
        },
        alacritty = {
          enabled = false,
          font = "14",
        },
        wezterm = {
          enabled = false,
          font = "+4",
        },
      },
      on_open = function(win)
        vim.cmd("highlight ZenBg guibg=#2E3440")
        vim.api.nvim_win_set_option(win.win, "winhighlight", "Normal:ZenBg")
      end,
      on_close = function()
        vim.cmd("highlight clear ZenBg")
      end,
    }
  }
}
