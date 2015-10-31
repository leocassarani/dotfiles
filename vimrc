let mapleader=","                 " Make , the leader key

filetype off                      " Disable filetype detection before Pathogen is loaded
call pathogen#infect()            " Load ALL the plugins
call pathogen#helptags()          " Load the help tags for all plugins

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SENSIBLE DEFAULTS, MOSTLY COMING FROM JANUS
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/settings.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                  " Vim, not vi
set number                        " Show line numbers
set ruler                         " Display line and column number

syntax enable                     " Enable syntax highlighting
set encoding=utf-8                " Use UTF-8 by default
set backspace=indent,eol,start  " Backspace through everything

set nowrap                        " Don't wrap long lines
set tabstop=2                     " A tab is two spaces long
set shiftwidth=2                  " Auto-indent using 2 spaces
set expandtab                     " Use spaces instead of tabs
set smarttab                      " Backspace deletes whole tabs at the beginning of a line
set sts=2                         " Backspace deletes whole tabs at the end of a line
set list                          " Show invisible characters
set nojoinspaces                  " Avoid double spaces when joining lines

set listchars=""                  " Reset listchars
set listchars=tab:\ \             " Display a tab as "  "
set listchars+=trail:.            " Display trailing whitespace as "."
set listchars+=extends:>          " Show ">" at the end of a wrapping line
set listchars+=precedes:<         " Show "<" at the beginning of a wrapping line

set hlsearch                      " Highlight search matches
set incsearch                     " Enable incremental searching
set ignorecase                    " Make searches case insensitive
set smartcase                     " (Unless they contain a capital letter)

set wildmenu                      " Sensible, powerful tab completion
set wildmode=list:longest,full    "

set mouse=a
set ttymouse=xterm2

""""""""""""""""""""""
" FILE TYPES TO IGNORE
""""""""""""""""""""""

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/ruby/*,*/vendor/plugins/*,*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/node_modules/*,*/.sass-cache/*,*/tmp/*
set wildignore+=*/ebin/*,*/dev/*,*/rel/*,*/deps/*
set wildignore+=*/.git/*,*/.rbx/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/.pew
set wildignore+=*.swp,*~,._*

""""""""""""""""""""""""""""""""""""
" WHERE TO PUT BACKUP AND SWAP FILES
""""""""""""""""""""""""""""""""""""

set backupdir=~/.vim_backup,/tmp
set directory=~/.vim_temp,/tmp

"""""""""""""""""""""""""""""""""""""""
" SET FILE TYPES FOR VARIOUS EXTENSIONS
"""""""""""""""""""""""""""""""""""""""

filetype on                       " Enable filetype detection
filetype indent on                " Enable filetype-specific indenting
filetype plugin on                " Enable filetype-specific plugins

function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.rabl} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown | call s:setupWrapping()
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.scss set filetype=scss

" Remember last location in a file, unless it's a git commit message
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

""""""""""""""""""""""""""""""""""""""""
" FILETYPE-SPECIFIC INDENTATION SETTINGS
""""""""""""""""""""""""""""""""""""""""

autocmd FileType {c,objc,erlang} setlocal shiftwidth=4 tabstop=4 sts=4
autocmd FileType {go} setlocal shiftwidth=8 tabstop=8 sts=8 noexpandtab

""""""""""
" MAPPINGS
""""""""""

" Make :W do the same as :w
command! W :w

" Hit return to clear search highlighting
noremap <cr> :nohlsearch<cr>

" Move around splits with Ctrl + HJKL
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Ctrl + L outputs a hashrocket in insert mode
imap <c-l> <space>=><space>

" <leader>= resizes all windows
map <leader>= <c-w>=

cnoremap %% <c-r>=expand('%:h').'/'<cr>

" <leader>e edits a file in the current path
map <leader>e :edit %%

" <leader>G opens the Git status window
map <leader>G :Gstatus<cr>

" Use F9 to toggle between paste and nopaste
set pastetoggle=<F9>

"""""""""
" COLOURS
"""""""""

set t_Co=256             " Use all 256 colours
set background=dark      " Dark terminal background
let base16colorspace=256 " Access colours present in 256 colorspace
color base16-tomorrow    " tomorrow-dark colour theme

""""""""""""""""""""
" MISC CONFIGURATION
""""""""""""""""""""

set shell=/bin/bash     " Make Vim load bash environment (e.g. RVM)
set timeoutlen=200     " Only wait 200ms before processing certain commands
set showcmd             " Display incomplete commands
set scrolloff=3         " Keep more lines when scrolling off the end of a buffer
set laststatus=2        " Show the statusline

" Set statusline to something sensible
" filename [encoding,line-endings][filetype] ... col,row/total-rows Position
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%h%m%r%=%c,%l/%L\ %P

"""""""""""""""""""""""
" CTRLP CUSTOM SETTINGS
"""""""""""""""""""""""

" Set up a bunch of <leader> key mappings for common Ruby/Rails directories
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gp :CtrlP public<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map <leader>C :CtrlPClearCache<cr>\|:CtrlP<cr>

" List files from top to bottom in CtrlP
let g:ctrlp_match_window_reversed = 0

" Set the maximum height of the match window:
let g:ctrlp_max_height = 30

" CtrlP shouldn't manage the current directory
let g:ctrlp_working_path_mode = 0

"""""""""""""""""""
" NERDTREE MAPPINGS
"""""""""""""""""""

" <leader>N to open and close NERDTree
map <leader>N :NERDTreeToggle<cr>

"""""""""""""""""
" TAGBAR MAPPINGS
"""""""""""""""""

" <leader>b to open and close Tagbar
map <leader>b :TagbarToggle<cr>

""""""""""""""""""""""""""""""""""""""""
" STRIP TRAILING WHITESPACE ON FILE SAVE
""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET (GARY BERNHARDT)
""""""""""""""""""""""""""""""""""""""""""""""""

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE (GARY BERNHARDT)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  let rails_project = isdirectory('app') > 0
  let in_lib = match(current_file, '^lib/') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    elseif in_lib && !rails_project
      let new_file = substitute(new_file, '^lib/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    elseif rails_project
      let new_file = new_file
    else
      let new_file = 'lib/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""
" RUNNING TESTS (GARY BERNHARDT)
""""""""""""""""""""""""""""""""

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        elseif filereadable("Makefile")
            exec "make test"
        else
            exec "go test -v ./..."
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        call RunTests('')
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MOVE WINDOW TO PREVIOUS/NEXT TAB
" http://vim.wikia.com/wiki/Move_current_window_between_tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MoveToPrevTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vsp
  else
    close!
    exe "0tabnew"
  endif
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vsp
  else
    close!
    tabnew
  endif
  exe "b".l:cur_buf
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""
" TOGGLE BETWEEN RELATIVE AND ABSOLUTE LINE NUMBERS
"""""""""""""""""""""""""""""""""""""""""""""""""""

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"""""""""
" HASKELL
"""""""""

autocmd FileType haskell map <buffer> <leader>t :!ghci %<cr>

"""""""
" RUBBY
"""""""

ab pry require 'pry'; binding.pry

""""""""
" GOLANG
""""""""

let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'passive_filetypes': ['go'] }

let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_disable_autoinstall = 1

let g:go_highlight_structs = 1

au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)

map <leader>gf :GoFmt<cr>
