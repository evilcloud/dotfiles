-- Open in full screen
vim.g.neovide_fullscreen = true

-- Only run Telescope if not a .txt file
if not vim.g.is_txt then
    vim.defer_fn(function()
        -- Launch Telescope
        vim.cmd("Telescope find_files")
    end, 0)
end

