set rtp+=/opt/homebrew/opt/fzf
set gp=git\ grep\ -n
set path+=**
set nocompatible

" File: video.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 25 Aug 2020 09:24:20 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" This is a list of useful mappings for vim

"  Args And Buffers {{{
nnoremap <leader>a   :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>b   :b <C-d>
" }}} 

" bookmarked directories {{{
nnoremap <leader>fp  :edit ~/Programming/**/*
nnoremap <leader>fd  :edit ~/Documents/**/*
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fh  :edit ~/**
" }}} " bookmarked directories

" Next Completion On / {{{ 1
" better navigation of command history
" allow next completion after / alternative
" is <C-E> if <C-D> makes to long of a list
if has('nvim-0.5.0')
	cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"
else
	cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
endif
" 1 }}} "Next Completion On /

" Commandline Abbreviations {{{
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))
" }}}

" Some Readline Keybindings When In Insertmode {{{
inoremap <C-A> <C-O>^<C-g>u
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>
			\strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
" }}}

" wildmenu {{{1 
set wildmenu                                   "Completion of commands
set wildmode=longest:full,full                 "How the completion is done
set wildignorecase                             "Case insensitive completion
set wildignore=*.git/*,.git/*,node_modules/*,*.tags,tags,*.o,*.class "what to ignore in completion
set wildignore+=__pycache__/*,*.pyc,*.pyo,*.pyd           "Python cache files
set wildignore+=.venv/*,venv/*,env/*,ENV/*                "Python virtual environments
set wildignore+=.DS_Store,*.swp,*.swo                     "System/editor files
set wildignore+=dist/*,build/*,*.egg-info/*               "Build directories
set wildignore+=coverage/*,.coverage,htmlcov/*            "Coverage files

" 1}}} "wildmenu

" splits {{{
" remember that you can use <c-w><c-s> to create a split 
set splitbelow
set splitright
" }}}

" for smartcase users {{{
" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
if exists('##CmdLineEnter')
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif
"  }}} for smartcase users

" vim:foldmethod=marker:foldlevel=0

" Find Under Root Directory {{{
function! FindRootDirectory()
	if !filereadable('Makefile') && !filereadable('makefile')
		" use git to find the top of the directory tree
		let root = systemlist('git rev-parse --show-toplevel')[0]
		if v:shell_error
			return '.'
		endif
		return root
	endif
	" If a makefile exists use that as the top of the directory tree
	return expand('%:p:h')
endfunction

nnoremap <leader>ff  :edit <c-r>=FindRootDirectory()<CR>/**/*
" }}}

" Quick buffer navigation (forgot to mention it in the video)
" inspired by vim-unimpaired https://github.com/tpope/vim-unimpaired
nnoremap ]b :silent! bnext<CR>
nnoremap [b :silent! bprevious<CR>
