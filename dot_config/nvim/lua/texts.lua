-- The directory where texts mode should open
local texts_dir = os.getenv("HOME") .. "/texts"

-- Check if the directory exists, if not, create it
if vim.fn.isdirectory(texts_dir) == 0 then
    vim.fn.mkdir(texts_dir, "p")
end

-- Change the working directory to the texts directory
vim.cmd("cd " .. texts_dir)

-- Check if Neovide is running
if vim.g.neovide then
    -- Other settings for texts mode
    local line_width = 140
    vim.cmd [[packadd goyo.vim]]
    vim.cmd("autocmd VimEnter * Goyo " .. line_width)
    
    -- Open in full screen
    vim.g.neovide_fullscreen = true

    -- Check if a .txt file is opened
    local filename = vim.fn.expand('%:t') -- gets the name of the current file
    vim.g.is_txt = string.match(filename, '.txt$') -- checks if the file is a .txt file

    -- Only run Telescope if not a .txt file
    if not vim.g.is_txt then
        vim.defer_fn(function()
            -- Launch Telescope
            vim.cmd("Telescope find_files")
        end, 0)
    end
end

