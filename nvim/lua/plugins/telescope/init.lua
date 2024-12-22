return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/harpoon",
  },
  opts = {
    defaults = {
      file_ignore_patterns = {},
      hidden = true,
    },
    pickers = {
      find_files = {
        hidden = true
      }
    },
    extensions = {
      harpoon = {
        -- You can add Harpoon-specific Telescope configurations here if needed
      }
    }
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    
    -- Load Harpoon extension
    telescope.load_extension("harpoon")
    
    -- Add custom command for finding hidden files
    vim.api.nvim_create_user_command('FindHiddenFiles', function()
      require('telescope.builtin').find_files({hidden = true})
    end, {})

    -- Add custom command for Harpoon marks
    vim.keymap.set("n", "<leader>h", function()
      telescope.extensions.harpoon.marks()
    end, { desc = "Harpoon marks in Telescope" })
  end
}
