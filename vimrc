" Header {{{
    " File: vimrc
    " Author: Jonathan Kim
    " Description: FusePump vimrc
    " Last Modified: October 19, 2012
" }}}

" General settings {{{

    set nocompatible                " not VI compatible
    set history=500                 " lines of history to remember
    set mouse=a                     " always enable mouse input

    set showmode                    " display the current mode
    set hidden                      " hides buffers instead of closing them
    set nobackup                    " no backup
    set noswapfile                  " no swapfile
    set pastetoggle=<F3>            " disables smart indenting when pasting from outside the terminal
    set undofile

    " Setup temp directory
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    
" File Formats {{{

    set fileformats=unix            " always use Unix file format

" }}}

" Style and Syntax {{{

    filetype plugin indent on       " enable file type check and indent
    syntax on                       " enable syntax highlighting
    set nu                          " set numbering rows

    set tabstop=4                   " spaces per tab
    set softtabstop=4
    set shiftwidth=4                " spaces per indent
    set expandtab                   " expand tabs to spaces
    set smarttab                    " at start shiftwidth, else tabstop
    set autoindent                  " indent new line to same as previous
    set smartindent                 " indent on code type
    set nolist                      " disable list on most files
    set foldenable                  " auto fold code

    set wrap
    set linebreak                   " wraps without <eol>
    set lcs=tab:├─                  " Tabs are shown as ├──├──
    set lcs+=trail:␣                " Show trailing spaces as ␣

    " Highlight the 81st column 
    set textwidth=80
    set colorcolumn=+1

" VIM UI {{{

    set ruler                       " always display cursor position
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set backspace=indent,eol,start  " backspace for dummys

    set incsearch                   " search as type
    set hlsearch                    " highlight search terms
    set ignorecase smartcase        " ignore case except explicit UC

    set scrolloff=4                 " keep cursor 5 lines from edge
    set sidescrolloff=10

    set tabpagemax=40               " max number opening tabs = ?
    set showtabline=1               " standard tabbed viewing

    set viminfo='100                " save marks and jumps in viminfo

    """ map <Space> to :noh and clear messages
    nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

    """ Folding
    set foldcolumn=2                " set width of folding column (appears on left side of ruler)
    set foldmethod=indent
    set foldlevel=0
    set foldlevelstart=0
    set foldminlines=1
    set foldnestmax=20

    autocmd BufNewFile,BufRead *.json set ft=javascript
    
" }}}

" Key (re)Mappings {{{

    "The default leader is '\', but many people prefer ',' as it's in a standard location
    let mapleader = ','
    let maplocalleader = "\\"

    """ Smart way to move windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    map gw <C-W>
    map gW <C-W>
    nnoremap <leader>w <C-w>v<C-w>l     " open new window in vertical split

    " Window resizing with arrow keys
    nmap <C-Down> <C-W>-<C-W>-
    nmap <C-Up> <C-W>+<C-W>+
    nmap <C-right> <C-W>><C-W>>
    nmap <C-left> <C-W><<C-W><

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Stupid shift key fixes
    cmap W w
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " ,l redraws the screen and removes any search highlighting.
    nnoremap <leader>l :nohl<CR>

    " Indent with spacebar
    nnoremap <tab> %
    vnoremap <tab> %

    " exhuma's .vimrc - https://github.com/exhuma/vimfiles/blob/master/.vimrc
    " {{{
        " Switch to previous/next buffer
        nmap <kMinus>  :bprevious<CR>
        nmap <kPlus>   :bnext<CR>
    " }}}

    inoremap <F1> <ESC>
    nnoremap <F1> <ESC>
    vnoremap <F1> <ESC>

    noremap <F12> <Esc>:syntax sync fromstart<CR>       " fix syntax highlighting problems
    inoremap <F12> <C-o>:syntax sync fromstart<CR>      " fix syntax highlighting problems

    " Strip all trailing whitespaces in a file
    nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" }}}

" Spelling {{{

    set spell                     " enable spell check

    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell " git commit messages
    au Filetype help setlocal nospell
    au StdinReadPost * setlocal nospell         " but not in man

    set spelllang=en_gb                         " spell check language to GB

    set dictionary+=/usr/share/dict/words       " add standard words
    
" }}}

" Completion {{{

    " automatically open and close the popup menu / preview window
    "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "set completeopt=longest,menuone,menu,preview

    "set omnifunc=syntaxcomplete#Complete
    "autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    "autocmd FileType less set omnifunc=csscomplete#CompleteCSS
    "autocmd FileType python set omnifunc=pythoncomplete#Complete
    "autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType coffee set omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    "autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" }}}
