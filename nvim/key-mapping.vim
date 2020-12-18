"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap te  :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap tm  :!mkdir <C-R>=expand("%:p:h") . "/" <CR>
nnoremap tn  :tabnext<Space>
nnoremap td  :tabclose<CR>
nnoremap tb  :e#<CR>
nnoremap gb :e#<CR>
" noremap <Leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" map dir
nnoremap <leader>. :lcd %:p:h<CR>
"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>
"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Copy/Paste/Cut
" if has('unnamedplus')
  " set clipboard=unnamed,unnamedplus
" endif

nmap ev :tabedit $MYVIMRC<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Split window
" nmap ss :split<Return><C-w>w
" nmap ss :split<Return><C-w>w
nmap sv :vsplit<CR>
nmap sv :vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" python excue
" nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
" nnoremap <F9> :w<CR>:exec '!python' shellescape(@%, 1)<cr>
" nnoremap <F5> :w<CR>:exec '!dotnet run' shellescape(@%, 1)<cr>
"ZZ to :w, ZX to :wq
" noremap zz :w<CR>
" noremap zx :wq<CR>
" noremap XXX :q!<CR>
nnoremap <leader>t :!open -a /Applications/iTerm.app .<cr>

" //****************************************************************************//
" //                               Plugin settings                              //
" //****************************************************************************//

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>
"" Open current line on GitHub
" nnoremap <Leader>o :.Gbrowse<CR>
nnoremap <silent> <space>b :Buffers<CR>
" nnoremap <silent> <leader>e :GFiles<CR>
nnoremap <silent> <c-p> :GFiles<CR>
" nnoremap <silent> <C-e> :GFiles<CR>
" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" frame command
nmap <space>uc :CommentFrameHashDash ""<Left>
let g:multi_cursor_select_all_word_key = '<space>n'

map <leader>su :%sort u<CR>
map <leader>sr :%sort!<CR>

nnoremap <leader>gwh :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pww :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <space>pwr :%s/<C-R>=expand("<cword>")<CR>/ .
