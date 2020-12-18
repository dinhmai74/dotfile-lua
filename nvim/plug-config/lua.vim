

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


"*****************************************************************************
"" Mappings
"*****************************************************************************

nnoremap <silent>gd :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent><F2> :lua vim.lsp.buf.rename()<CR>
nnoremap <silent>K   :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ac :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>[g :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" <Plug>VimspectorStop
" <Plug>VimspectorPause
" <Plug>VimspectorAddFunctionBreakpoint
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

autocmd BufWritePost * lua vim.lsp.buf.formatting()
