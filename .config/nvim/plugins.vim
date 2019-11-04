" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" auto-close plugin
Plug 'rstacruz/vim-closer'
Plug 'voldikss/vim-floaterm'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === Javascript Plugins === "
" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" === Syntax Highlighting === "
Plug 'sheerun/vim-polyglot'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Colorscheme
Plug 'rafi/awesome-vim-colorschemes'
Plug 'haishanh/night-owl.vim'

" Customized vim status line
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'terryma/vim-multiple-cursors'


call plug#end()
