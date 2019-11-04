scriptencoding=UTF-8
source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
let g:mapleader=','

" Disable line numbers
set nonumber

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamed

" Hides buffers instead of closing them
set hidden

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab

set tabstop=4

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "


" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NERDTree === "
" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Wrap in try/catch to avoid errors on initial install before plugin is available

" === Lightline ==== "



  let g:lightline = {
      \ 'colorscheme': 'nightowl',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [  'gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'readonly': 'LightlineReadonly',
      \   'errors': 'LinterStatus',
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ },
      \ 'subseparator': { 'right': ' ❮', 'left': ' ❯' }
      \ }
  "}}

  function! LightlineReadonly()
    return &readonly && &filetype !=# 'help' ? 'RO' : ''
  endfunction

" === Signify === "
let g:signify_sign_delete = '-'

" === Ale === "
"let g:ale_sign_highlight_linenrs=1
let g:ale_sign_warning='▲'
let g:ale_sign_error='✘'
let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'javascript': ['prettier', 'eslint'],
      \}

  " Fix files automatically on save
let g:ale_fix_on_save = 1


" === Ale === "
let g:floaterm_position='center'
" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
if (has('termguicolors'))
  set termguicolors
endif

" Editor theme
" === Color Scheme === "
try
  colorscheme night-owl
catch
  colorscheme dracula
endtry

" Signify color changes
highlight DiffAdd ctermfg=233 ctermbg=149 guifg=#addb67 guibg=#011627
highlight DiffChange ctermfg=233 ctermbg=222 guifg=#ecc48d guibg=#011627
highlight DiffDelete ctermfg=233 ctermbg=204 guifg=#ff5874 guibg=#011627
highlight ALEWarningSign ctermfg=233 ctermbg=222 guifg=#fff85e guibg=#011627
highlight ALEErrorSign ctermfg=233 ctermbg=222 guifg=#cb3234   guibg=#011627
highlight ALEError guifg=#cb3234


" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

"hi! link CocErrorSign WarningMsg
"hi! link CocWarningSign Number
"hi! link CocInfoSign Type

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c
" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === FZF shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor

  map <C-p> :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>w :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :History:<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg ')<CR>

  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:

" === Nerdtree shorcuts === "
"  <leader>f - Toggle NERDTree on/off
"  <leader>v - Opens current file location in NERDTree"
"
  nmap <silent> <leader>f :NERDTreeToggle<cr>
  " find the current file in nerdtree without needing to reload the drawer
  nmap <silent><leader>v :call NERDTreeToggleAndFind()<cr>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>


"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> <leader>l :nohlsearch<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP



  "NERDCOMMENTER"

  let g:NERDCreateDefaultMappings = 0
  xmap <leader>cc <plug>NERDCommenterSexy
  nmap <leader>cc <plug>NERDCommenterToggle

  "Shortcut to quit
  noremap <leader>q :q<cr>
  "Shortcut to save
  nmap <leader>, :w<cr>
  "Remove search highlight
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

  "Move between tabs in vim
  nnoremap <C-j> :tabprevious<CR>
  nnoremap <C-k> :tabnext<CR>
  nnoremap <C-c> :tabclose<CR>

  "Move between errors
  nmap <silent>[e <Plug>(ale_previous_wrap)
  nmap <silent>]e <Plug>(ale_next_wrap)

  "Terminal
let g:floaterm_keymap_new    = '<leader>ª'
let g:floaterm_keymap_prev   = '<leader>1'
let g:floaterm_keymap_next   = '<leader>2'
let g:floaterm_keymap_toggle = '<leader>º'
" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile
