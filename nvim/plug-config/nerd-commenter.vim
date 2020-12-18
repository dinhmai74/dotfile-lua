nnoremap <silent> <space>/ :Commentary<CR>
vnoremap <silent> <space>/ :Commentary<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
