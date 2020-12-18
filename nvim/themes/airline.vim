

" #  ----vimariline----#
let g:airline_theme="onedark"
let g:airline#extensions#tabline#enabled = 0

try
  " Enable extensions
  let g:airline_extensions = ['branch', 'hunks', 'coc']
  
  " Update section z to just have line number
  let g:airline_section_z = airline#section#create(['linenr'])
  
  " Do not draw separators for empty sections (only for the active window) >
  let g:airline_skip_empty_sections = 1
  
  " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  
  " Custom setup that removes filetype/whitespace from default vim airline bar
  let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
  
  " Customize vim airline per filetype
  " 'nerdtree'  - Hide nerdtree status line
  " 'list'      - Only show file type plus current line number out of total
  let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
    \ 'list': [ '%y', '%l/%L'],
    \ }
  
  " Enable powerline fonts
  let g:airline_powerline_fonts = 1
  
  " Enable caching of syntax highlighting groups
  let g:airline_highlighting_cache = 1
  
  " Define custom airline symbols
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  
  " Don't show git changes to current file in airline
  let g:airline#extensions#hunks#enabled=0
  
  if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
  endif

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

