syntax on
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

func! s:gruvbit_setup() abort
    hi Comment gui=italic cterm=italic
    hi Statement gui=bold cterm=bold
    hi VertSplit guibg=NONE ctermbg=NONE
endfunc

augroup colorscheme_change | au!
   au ColorScheme gruvbit call s:gruvbit_setup()
augroup END

" let g:gruvbit_transp_bg = v:true

set background=dark
set termguicolors
colorscheme gruvbit
