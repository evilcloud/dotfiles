-- Load the fullscreen plugin for Neovim
vim.cmd [[packadd vim-fullscreen]]
vim.cmd [[FullscreenToggle]]

-- Only run Telescope if not a .txt file
if not vim.g.is_txt then
    vim.defer_fn(function()
        -- Launch Telescope
        vim.cmd("Telescope find_files")
    end, 0)
end

