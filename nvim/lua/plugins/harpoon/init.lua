return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
      { desc = "Harpoon add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon quick menu" })

    -- New mappings for removing Harpoon marks
    vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end,
      { desc = "Remove current file from Harpoon" })

    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end,
      { desc = "Clear all Harpoon marks" })

    vim.keymap.set("n", "<leader>hr", function()
      vim.ui.input({ prompt = "Enter Harpoon mark index to remove: " }, function(input)
        local index = tonumber(input)
        if index then
          harpoon:list():removeAt(index)
          print("Removed Harpoon mark at index " .. index)
        else
          print("Invalid index")
        end
      end)
    end, { desc = "Remove Harpoon mark by index" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end,
      { desc = "Harpoon prev" })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end,
      { desc = "Harpoon next" })
  end
}
