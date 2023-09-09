return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdtree'
    use 'folke/tokyonight.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'reedes/vim-wordy'
    use 'tpope/vim-fugitive'
    use 'lambdalisue/vim-fullscreen' -- Fullscreen plugin for terminal Neovim
    use {'junegunn/goyo.vim', opt = true}
    use {'Pocco81/TrueZen.nvim', opt = true}
end)

