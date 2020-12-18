" auto-install vim-plug
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
  " silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    " \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " "autocmd VimEnter * PlugInstall
  " autocmd VimEnter * PlugInstall | source $MYVIMRC
" endif
"*****************************************************************************
"" Basic Settings
"*****************************************************************************
syntax on
set mouse=v
" "" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set nu
set relativenumber
set cindent
au FileType * set fo-=c fo-=r fo-=o "disable auto comment new line
set noshowmatch
set nohlsearch
set noerrorbells
set noswapfile
set undodir=~/.vim/undodir
set undofile
set termguicolors
" set scrolloff=8
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
set autoread
" don't give |ins-completion-menu| messages.
" always show signcolumns
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set laststatus=2                        " Always display the status line
set showtabline=2                       " Always show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set timeoutlen=200                      " By default timeoutlen is 1000
" Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
set guifont=Fira\ Code\ Nerd\ Font
set noerrorbells

call plug#begin('~/.vim/plugged')
" Track the engine.
Plug 'SirVer/ultisnips'

" Neovim lsp Plugins
Plug 'tjdevries/lsp_extensions.nvim'
" Install this plugin.
Plug 'tjdevries/nlua.nvim'
" (OPTIONAL): If you want to use built-in LSP (requires Neovim HEAD)
"   Currently only supported LSP, but others could work in future if people send PRs :)
Plug 'neovim/nvim-lspconfig'
" (OPTIONAL): This is recommended to get better auto-completion UX experience for builtin LSP.
Plug 'nvim-lua/completion-nvim'
" (OPTIONAL): This is a suggested plugin to get better Lua syntax highlighting
"   but it's not currently required
Plug 'euclidianAce/BetterLua.vim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

"  I AM SO SORRY FOR DOING COLOR SCHEMES IN MY VIMRC, BUT I HAVE
"  TOOOOOOOOOOOOO
Plug 'morhetz/gruvbox'

" Utils
Plug 'voldikss/vim-floaterm'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

Plug 'mhinz/vim-startify' " Start screen
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-sort-motion'
Plug 'cometsong/commentframe.vim'
Plug 'tpope/vim-repeat' 
Plug 'tpope/vim-abolish' "turn case crs crc etc
Plug 'Yggdroot/indentLine' " display indents (for yam) :IndentLineToggle
   " #------------------------------------------------------------------------------#
" #                                 react things                                 #
" #------------------------------------------------------------------------------#
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'alvan/vim-closetag'
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
call plug#end()


"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev q1 q!
cnoreabbrev or OR
cnoreabbrev w1 w!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev qa1 qa!
cnoreabbrev ag Ag
cnoreabbrev rg Rg
cabbrev t tabnew
nnoremap ; :
vnoremap ; :
"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e
command! EditConfig :tabe ~/.config

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" #------------------------------------------------------------------------------#
" #                                plugin settings                               #
" #------------------------------------------------------------------------------#

let g:indentLine_char = '┊'
let g:NERDSpaceDelims = 1
" let g:vim_jsx_pretty_colorful_config = 1
" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
" #------------------------------------------------------------------------------#
" #                                custom settings                               #
" #------------------------------------------------------------------------------#

" autocmd FileType apache setlocal commentstring=#\ %s
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
" create a dir if not exists when use te command
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

au FileType * set fo-=c fo-=r fo-=o
autocmd Filetype json let g:indentLine_setConceal = 0

let g:vim_json_syntax_conceal = 0
" for jsx comment
"Start the completion menu with CTRL-N/CTRL-P, then run this map.
if executable('rg')
    let g:rg_derive_root='true'
endif

" #------------------------------------------------------------------------------#
" #                                import settings                               #
" #------------------------------------------------------------------------------#

source $HOME/.config/nvim/themes/syntax.vim
source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/plug-config/nerd-commenter.vim
source $HOME/.config/nvim/plug-config/vim-rooter.vim
source $HOME/.config/nvim/plug-config/start-screen.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/git.vim
source $HOME/.config/nvim/plug-config/session.vim
source $HOME/.config/nvim/CustomConfig/extract-variable.vim
source $HOME/.config/nvim/plug-config/floaterm.vim
source $HOME/.config/nvim/plug-config/lua.vim
source $HOME/.config/nvim/plug-config/completion.vim
source $HOME/.config/nvim/key-mapping.vim
