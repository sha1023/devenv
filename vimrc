set nu
syntax on
set autoindent
set tabstop=4 shiftwidth=4 expandtab
set hlsearch
set nowrap

" Show trailing whitespace:
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
