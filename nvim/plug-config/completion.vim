    " Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<c-j>"
  " let g:UltiSnipsJumpForwardTrigger="<c-b>"
  " let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> <Plug>(completion_trigger)
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'
autocmd BufWritePost * lua vim.lsp.buf.formatting()
autocmd BufWritePre *.tsx lua vim.lsp.buf.code_action({ source = { organizeImports = true } })
let g:completion_enable_snippet = 'UltiSnips'
