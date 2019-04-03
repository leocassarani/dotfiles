packadd minpac

call minpac#init()

call minpac#add('k-takata/minpac', { 'type': 'opt' })

" basics
call minpac#add('tpope/vim-sensible')
call minpac#add('danielwe/base16-vim')

" languages
call minpac#add('fatih/vim-go')
call minpac#add('mxw/vim-jsx')
call minpac#add('pangloss/vim-javascript')
call minpac#add('rust-lang/rust.vim')
call minpac#add('tpope/vim-markdown')
call minpac#add('vim-ruby/vim-ruby')

" editing
call minpac#add('airblade/vim-gitgutter')
call minpac#add('ervandew/supertab')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('vim-syntastic/syntastic')

" snippets
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('tomtom/tlib_vim')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')

" navigation
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('kien/ctrlp.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('majutsushi/tagbar')

" defaults
set number                        " show line numbers
set list                          " show invisible characters

set listchars=""                  " reset listchars
set listchars=tab:\ \             " display a tab as "  "
set listchars+=trail:.            " display trailing whitespace as "."
set listchars+=extends:>          " show ">" at the end of a wrapping line
set listchars+=precedes:<         " show "<" at the beginning of a wrapping line

set hlsearch                      " highlight search matches
set incsearch                     " enable incremental searching
set ignorecase                    " make searches case-insensitive
set smartcase                     " unless they contain a capital letter

set mouse=a
set ttymouse=xterm2

" remember last location in a file, unless it's a git commit message
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" colorscheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" filetypes
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/target/*,*/vendor/*,*/.bundle/*,*/node_modules/*,*/.sass-cache/*,*/tmp/*
set wildignore+=*/dev/*,*/rel/*,*/deps/*
set wildignore+=*/.git/*,*/.rbx/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/.pew
set wildignore+=*.swp,*~,._*

""""""""""""
" mappings "
""""""""""""

let mapleader=","

" make :W do the same as :w
command! W :w

" hit return to clear search highlighting
noremap <cr> :nohlsearch<cr>

" ctrl + L outputs a hashrocket in insert mode
imap <c-l> <space>=><space>

" %% expands to the current directory
cnoremap %% <c-r>=expand('%:h').'/'<cr>

" <leader>e edits a file in the current path
map <leader>e :edit %%

" use F9 to toggle between paste and nopaste
set pastetoggle=<F9>

" List files from top to bottom in CtrlP
let g:ctrlp_match_window_reversed = 0

" Set the maximum height of the match window:
let g:ctrlp_max_height = 30

" CtrlP shouldn't manage the current directory
let g:ctrlp_working_path_mode = 0

map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map <leader>C :CtrlPClearCache<cr>\|:CtrlP<cr>

" <leader>N to open and close NERDTree
map <leader>N :NERDTreeToggle<cr>

"""""""""""
" editing "
"""""""""""

set expandtab shiftwidth=2 softtabstop=2

set nobackup
set noswapfile

" persistent undo
set undodir=$HOME/.vim/undodir
set undofile

autocmd FileType {c,erlang,objc,rust} setlocal shiftwidth=4 tabstop=4 sts=4
autocmd FileType {go} setlocal shiftwidth=8 tabstop=8 sts=8 noexpandtab

""""""""""""""""""""""""""""""""""""""""""
" strip trailing whitespace on file save "
""""""""""""""""""""""""""""""""""""""""""

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (GARY BERNHARDT)
""""""""""""""""""""""""""""""""""""""

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""
" GOLANG
""""""""

let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_disable_autoinstall = 1
let g:go_highlight_structs = 1

""""""""
" RUST "
""""""""

let g:rustfmt_autosave = 1
