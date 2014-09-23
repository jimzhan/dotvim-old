""  ------------------------------------------------------------
" *  @file       dotvim.vim
" *  @date       2014
" *  @author     Jim Zhan <jim.zhan@me.com>
" *
" Copyright © 2014 Jim Zhan.
" ------------------------------------------------------------
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" ------------------------------------------------------------
"  Enviroment
" ---------------------------------------------------------------------------
set nocompatible
set background=dark
source $HOME/.vim/foundation.vim
" ------------------------------------------------------------
" Windows Compatible
" ---------------------------------------------------------------------------
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has("multi_byte")
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        set termencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15,chinese,euc-jp,gb18030,gbk,big5,latin1
    endif
endif


" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------
set background=dark         " Assume a dark background
if !has('gui')
  set term=$TERM            " Make arrow and other keys work
endif
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
scriptencoding utf-8

if g:dotvim.use_system_clipboard
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
endif
" ---------------------------------------------------------------------------
if g:dotvim.autochdir
    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endif

set autowrite                                   " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
"set spell                                       " Spell checking on
set hidden                                      " Allow buffer switching without saving
set iskeyword-=.                                " '.' is an end of word designator
set iskeyword-=#                                " '#' is an end of word designator
set iskeyword-=-                                " '-' is an end of word designator

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc file:
" ---------------------------------------------------------------------------
"  let g:dotvim.restore_cursor = 0
" ---------------------------------------------------------------------------
if g:dotvim.restore_cursor
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif

" Setting up the directories
set backup                      " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" To disable views add the following to your .vimrc file:
" ---------------------------------------------------------------------------
"  let g:dotvim.no_views = 1
" ---------------------------------------------------------------------------
if !exists('g:dotvim.no_views')
    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
        \ '\[example pattern\]'
        \ ]
endif


" ---------------------------------------------------------------------------
"  Vim UI
" ---------------------------------------------------------------------------
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
set colorcolumn=80              " Enable Vertical Color Column at 80.

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

set laststatus=2                " For vim-airline
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" toggle folding using `space`.
"   do not fold lines under 5.
"set foldlevel=9
"set foldminlines=6
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>



" ---------------------------------------------------------------------------
"  Formatting
" ---------------------------------------------------------------------------
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" ---------------------------------------------------------------------------
if g:dotvim.trailing_whitespace
    autocmd FileType c,cpp,coffee,html,java,php,javascript,puppet,python,rust,twig,xml,yml,perl 
            \ autocmd BufWritePre <buffer> call dotvim.StripTrailingWhitespace()
endif
" ---------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,html,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell,rust setlocal nospell


" ---------------------------------------------------------------------------
"  Key Mappings
" ---------------------------------------------------------------------------
imap jj <ESC>           " Shortcut to ESC
let mapleader = ','     " The default Leader is '\'.
" Code folding options
nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>
nmap <leader>7 :set foldlevel=7<CR>
nmap <leader>8 :set foldlevel=8<CR>
nmap <leader>9 :set foldlevel=9<CR>
" Buffer Switching
:nmap <C-l>     :bnext<CR>
:nmap <C-h>     :bprevious<CR>
:nmap <C-k>     :bdelete<CR>
" Tabs
:nmap <S-t>     :tabnew<CR>
:nmap <S-w>     :tabclose<CR>
:nmap <S-h>     :tabprevious<CR>
:nmap <S-l>     :tabnext<CR>


" ---------------------------------------------------------------------------
"  GUI: basic gvim settings instead of .gvimrc.
" ---------------------------------------------------------------------------
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set lines=80                " 80 lines height for workspace
    set columns=130             " 130 columns width for workspace
    set guioptions-=T           " Remove the toolbar
    set shell=/bin/bash         " Use basic bash ONLY.

    if has("gui_macvim")
        set guifont=PragmataPro:h14,Menlo\ Regular:h14
    elseif has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
endif


" ---------------------------------------------------------------------------
" Plugins Manager: Setup Plugins Support.
" ---------------------------------------------------------------------------
call dotvim.InitializePlugins(expand('~/.vimrc.plugins'))


" ---------------------------------------------------------------------------
" Color Theme: Molokia with custom error sign symbol.
" ---------------------------------------------------------------------------
colorscheme molokai


" ---------------------------------------------------------------------------
" Finalize: Post settings & restting colors.
" ---------------------------------------------------------------------------
call dotvim.Finalize()
