return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      disable_frontmatter = true,
      workspaces = {
        {
          name = "vault",
          path = "~/Vaults",
        },
      },
      attachments = {
        img_folder = "assets/imgs",
      },
      templates = {
        folder = "~/Vaults/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
      new_notes_location = "notes_subdir",
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      wiki_link_func = "use_alias_only",
      follow_url_func = function(url)
        vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
    },
  }
}
