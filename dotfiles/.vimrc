" SPDX-License-Identifier: GPL-3.0-or-later
"
" Copyright (C) 2020 Saurabh Charde <saurabhchardereal@gmail.com>
"

filetype plugin indent on   " Used for indentation based on file-type
syntax enable               " Enable syntax highlighting
set statusline+=\ %l\:%v    " Show line and column
set wrap!                   " Do not wrap code by default

" We do not use TAB = 8 spaces for most file types, so set TAB = 4 by default
" Took from https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
set expandtab               " Expand TABs to spaces
set shiftwidth=4            " Indents will have a width of 4
set tabstop=4               " The width of a TAB is set to 4.
                            " Still it is a \t. It is just that
                            " Vim will interpret it to be having
                            " a width of 4.
set softtabstop=4           " Sets the number of columns for a TAB
