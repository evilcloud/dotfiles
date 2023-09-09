-- The directory where texts mode should open
local texts_dir = os.getenv("HOME") .. "/texts"

-- Check if Packer is installed 
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Load the plugins
require('plugins')

-- Install/update plugins
vim.cmd [[autocmd VimEnter * PackerInstall]]

-- Set up the tokyonight theme
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

-- Linebreaks are necessary for all cases
vim.o.linebreak = true

-- Check if in texts mode
local filepath = vim.fn.expand('%:p:h') -- gets the full path of the current file
vim.g.texts_mode = vim.g.neovide or string.match(filepath, texts_dir) -- checks if Neovide is launched or if Neovim is opened from the texts directory

-- Check if a .txt file is opened
local filename = vim.fn.expand('%:t') -- gets the name of the current file
vim.g.is_txt = string.match(filename, '.txt$') -- checks if the file is a .txt file

if vim.g.texts_mode then
    require('texts')
else
    require('neovim')
end

