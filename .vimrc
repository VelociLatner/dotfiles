call pathogen#infect()
colorscheme desert

syntax on
filetype plugin on

set smartindent
set tags=~/.tags
set complete=.,w,b,u,t,i

set laststatus=2

set shell=bash\ -i
set lines=50
set columns=180

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc'

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif
