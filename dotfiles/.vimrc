" Dude's .vimrc

" we also use ~/.vim/plugin/:
"
" grep.vim
" supertab.vim
"
" check those plugin configs for how they work, etc...

" this is vim.. not vi
set nocompatible

" let pastes work without fucking w/ 'supertab'
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

" syntax highlighting
syntax on
filetype on
filetype plugin on

" turn off auto commenting ('filetype on' must appear before this!)
au FileType * setl fo-=cro

" LINUX
" swap the escape key with CAPS-LOCK
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" Put the CAPS-LOCK key back to normal when quiting VIM
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'


" set backspace to actually work!
set backspace=indent,eol,start

" Vim UI {
    set cursorcolumn " highlight the current column
    set cursorline " highlight current line
    highlight CursorLine term=underline cterm=underline ctermbg=none
    highlight CursorColumn term=none cterm=none ctermbg=DarkGray
    set incsearch " BUT do highlight as you type you search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines betweens rows
    set list " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:>-,trail:- " show tabs and trailing 
    set matchtime=5 " how many tenths of a second to blink matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current 
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in 
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
" }

" Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions
    set expandtab " no real tabs please!
    set formatoptions=rq " insert comment leader on return and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=2 " autoindent amount when using cindent >> << and stuff like that
    set softtabstop=2 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=2 " ruby tabs should be 2, and they will show with set list on
" }
