cat << EOF >> .vimrc
syntax on
filetype on
filetype plugin on

" set noswapfile
"
set hlsearch "highlight search "
set ignorecase "ignore case on search"
set incsearch "incremental search (searches as you type)"
set number "sets number lines"
set relativenumber "relative number lines"
set backspace=indent,eol,start "makes backspce normal"
set showcmd "show what you are typing in the corner"
set mouse=a "allows mouse input"
set smartindent "indent, but smart"
set expandtab "use spaces when tabbing"
set tabstop=4 "how many spaces tab is"
set shiftwidth=4 "how many spaces >> is"

"set foldmethod=syntax "fold on"
"set foldclose=all "auto close"
EOF
