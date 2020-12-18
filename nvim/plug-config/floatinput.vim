
" #------------------------------------------------------------------------------#
" #                                  Float input                                 #
" #------------------------------------------------------------------------------#
autocmd ColorScheme *
      \ hi CocHelperNormalFloatBorder guifg=#dddddd guibg=#575B54
      \ | hi CocHelperNormalFloat guibg=#575B54
" Remap for rename current word
nmap <F2> <Plug>(coc-floatinput-rename)
