require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Existing mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

-- Hop mappings
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

-- Obsidian mappings
vim.keymap.set("n", "<leader>on", function()
  vim.cmd("ObsidianTemplate note")
  vim.cmd([[1,/^\S/s/^\n\{1,}//]])
end)
vim.keymap.set("n", "<leader>od", function()
  vim.cmd("ObsidianTemplate daily")
  vim.cmd([[1,/^\S/s/^\n\{1,}//]])
end)
vim.keymap.set("n", "<leader>ow", function()
  vim.cmd("ObsidianTemplate writing")
  vim.cmd([[1,/^\S/s/^\n\{1,}//]])
end)
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd("ObsidianTemplate contact")
  vim.cmd([[1,/^\S/s/^\n\{1,}//]])
end)
vim.keymap.set("n", "<leader>ob", function()
  vim.cmd("ObsidianTemplate books")
  vim.cmd([[1,/^\S/s/^\n\{1,}//]])
end)
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("ObsidianTags")
end)

-- Zen mode
vim.keymap.set("n", "<leader>zn", ":ZenMode<cr>")

-- Disable the default NvChad horizontal terminal keybinding
vim.keymap.del("n", "<leader>h")

-- Add Harpoon Telescope integration
vim.keymap.set("n", "<leader>h", function()
  require("telescope").extensions.harpoon.marks()
end, { desc = "Harpoon marks in Telescope" })

-- If you want to disable other default NvChad mappings, you can do it like this:
local M = {}
M.disabled = {
  n = {
    ["<leader>h"] = "",
    -- Add any other mappings you want to disable
  }
}

return M
