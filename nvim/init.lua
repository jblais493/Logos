vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.o.conceallevel = 2

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
  end,
})

-- AutoPDF functionality
local script_path = vim.fn.stdpath('config') .. '/scripts/auto_md_to_pdf.sh'

local function start_auto_pdf()
    local buf = vim.api.nvim_get_current_buf()
    if not vim.b[buf].auto_pdf_job then
        local file = vim.fn.expand('%:p')
        if vim.fn.filereadable(script_path) == 1 then
            vim.b[buf].auto_pdf_job = vim.fn.jobstart({script_path, file}, {
                on_exit = function(job_id, exit_code, event_type)
                    print("AutoPDF job exited with code: " .. exit_code)
                    vim.b[buf].auto_pdf_job = nil
                end
            })
            if vim.b[buf].auto_pdf_job == 0 then
                print("Error: Invalid arguments in AutoPDF job")
                vim.b[buf].auto_pdf_job = nil
            elseif vim.b[buf].auto_pdf_job == -1 then
                print("Error: AutoPDF job failed to start")
                vim.b[buf].auto_pdf_job = nil
            else
                print("AutoPDF started")
            end
        else
            print("Error: auto_md_to_pdf.sh script not found")
        end
    else
        print("AutoPDF is already running")
    end
end

local function stop_auto_pdf()
    local buf = vim.api.nvim_get_current_buf()
    if vim.b[buf].auto_pdf_job then
        vim.fn.jobstop(vim.b[buf].auto_pdf_job)
        vim.b[buf].auto_pdf_job = nil
        print("AutoPDF stopped")
    else
        print("AutoPDF is not running")
    end
end

vim.api.nvim_create_autocmd({"BufUnload"}, {
    pattern = {"*.md"},
    callback = stop_auto_pdf
})

vim.api.nvim_create_user_command('StartAutoPDF', start_auto_pdf, {})
vim.api.nvim_create_user_command('StopAutoPDF', stop_auto_pdf, {})
