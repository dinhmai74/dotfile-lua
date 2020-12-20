vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
return packer.startup(function()
    local use = use
    use {'wbthomason/packer.nvim', opt = true}
    use 'RishabhRD/nvim-finder'
    use 'RishabhRD/nvim-lsputils'
    use 'RishabhRD/popfix'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'honza/vim-snippets'
    use 'SirVer/ultisnips'
    use 'tpope/vim-commentary'
    use 'mbbill/undotree'
    use 'nvim-treesitter/nvim-treesitter'
    use 'mhinz/vim-startify'
    use 'nvim-lua/plenary.nvim'
    use 'tjdevries/express_line.nvim'
    use 'szw/vim-maximizer'
    use 'ryanoasis/vim-devicons'
    use 'gruvbox-community/gruvbox'
    use 'voldikss/vim-floaterm'
    use 'scrooloose/nerdcommenter'
    use 'tpope/vim-surround'
    use 'terryma/vim-multiple-cursors'
    use 'christoomey/vim-system-copy'
    use 'christoomey/vim-sort-motion'
    use 'cometsong/commentframe.vim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    use 'Yggdroot/indentLine'
    use 'alvan/vim-closetag'
    use 'tpope/vim-fugitive'
    use 'stsewd/fzf-checkout.vim'
    use 'airblade/vim-rooter'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-rhubarb'
    use 'jiangmiao/auto-pairs'
    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'}, {'junegunn/fzf.vim'} -- to enable preview (optional)
        }
    }

end)
