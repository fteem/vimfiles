" Point to pathogen autoload file
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Load pathogen bundled plugins
execute pathogen#infect()

" Turn on syntax highlighting
syntax on

" Load ftplugins and indent files
filetype plugin indent on

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Change the mapleader from \ to ,
let mapleader = ","

" Avoid annoying CSApprox warning message
let g:CSApprox_verbose_level = 0

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set command line history limit
set history=1000

" Show the cursor position all the time
set ruler

" Show incomplete commands at the bottom
set showcmd

" Show current mode at the bottom
set showmode

" Highlight search matches
set hlsearch

" Highlight search match as you type
set incsearch

" Display line numbers
set number

" Display ... as wrap break
set showbreak=...

" Proper wrapping
set wrap linebreak nolist

" Add some line space for easy reading
set linespace=4

" Disable visual bell
set visualbell t_vb=

" gvim
if has("autocmd")&&  has("gui")
  au GUIEnter * set t_vb=
endif

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Statusline setup (tail of the filename)
set statusline=%f
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Turn off toolbar on GVim
set guioptions-=T

" Recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" Indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Folding settings
set foldmethod=indent

" Set deepest folding to 3 levels
set foldnestmax=3

" Don't fold by default
set nofoldenable

" Activate TAB auto-complete for file paths
set wildmode=longest,list

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"some stuff to get the mouse going in term
" set mouse=a
" set ttymouse=xterm2

"allow backgrounding buffers without saving them
set hidden

" Max 80 chars per line
set colorcolumn=81

if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256
  set term=gnome-256color

  colorscheme railscasts
  " set guifont=Monospace\ Bold\ 12
  " colorscheme desert
  " colorscheme vividchalk

  " colorscheme solarized
  " syntax enable
  " set background=light
  " set background=dark
else
  "dont load csapprox if there is no gui support - silences an annoying warning
  "let g:CSApprox_loaded = 1

  set term=xterm-256color

  " colorscheme codeschool
  " colorscheme desert
  " colorscheme distinguished
  " colorscheme grb256
  " colorscheme railscasts
  " colorscheme twilight
  " colorscheme vividchalk
  colorscheme jellybeans
  " colorscheme desert
  " colorscheme vividchalk

  " solarized
  " let g:solarized_termcolors=256
  " syntax enable
  " set background=dark
  " set background=light
  " colorscheme solarized
endif

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" Strip trailing whitespace
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

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

"snipmate setup
source ~/.vim/snippets/support_functions.vim
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()
    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
      call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
      call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
endfunction

" Ctrl p
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-f>'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.gif,*.png,*.pdf
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.png$\|\.gif$\|\.jpg$',
  \ }


" File types to ignore on tab auto-complete
"set wildignore+=*.o,*.obj,.git,*.png,*.PNG,*.JPG,*.jpg,*.GIF,*.gif,*.zip,*.ZIP,*.eot,*.svg,*.csv,*.ttf,*.svg,*.eof,*.ico,*.woff,vendor/**,coverage/**,tmp/**,rdoc/**,*.sqlite3

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>
" map <leader>gg :topleft 100 :split Gemfile<cr>

" BufExplorer
"map <Leader>j :BufExplorer<CR>
"nmap <c-b> :BufExplorer<CR>
"nnoremap <leader>b :BufExplorer<cr>
" default mapings
"<leader>be (normal open)
"<leader>bs (force horizontal split open)
"<leader>bv (force vertical split open)

" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
"let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 40
" open file browser
map <leader>p :NERDTreeToggle<cr>
" Open NERDTree by default
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" Rails
" open Rails model
map <Leader>m :Rmodel
" open Rails controller
map <Leader>c :Rcontroller
" open Rails view
map <Leader>v :Rview
" open Rails unit test
map <Leader>u :Runittest

" Ack
" Use Ack instead of grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
set grepprg=ack
" search for string in files
nmap <leader>f :Ack

" Scenario Outline align
vmap <c-a> :Align \|<CR>

" use :w!! to write to a file using sudo if you forgot to "sudo vim file"
cmap w!! %!sudo tee > /dev/null %

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" use X11 clipboard for yank and paste
set clipboard=unnamedplus

" work-around to copy selected text to system clipboard
" and prevent it from clearing clipboard when using ctrl + z (depends on xsel)
function! CopyText()
  normal gv"+y
  :call system('xsel -ib', getreg('+'))
endfunction
vmap <leader>y :call CopyText()<cr>

" Paste/Replate mappings
" Paste last yanked text
map <c-p> "0p
" replace selected text with yanked text
" vmap ; "_dP
" vmap ' "_dp

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map ESC
imap jj <ESC>
imap <c-c> <ESC>

" insert =>
imap <c-l> <space>=><space>

" Buffers
" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" close buffer
"nmap <leader>d :bd<CR>
nmap <leader>d :bprevious<CR>:bdelete #<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Go to vim shell
map <leader>sh :sh<cr>

" Edit/View files relative to current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>re :edit %%
map <leader>rv :view %%

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

iabbrev ilor Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum


function! AckGrep()
  normal ebvey
  exec ":!ack-grep " . @"
endfunction

map <leader>ag :call AckGrep()<cr>

" xnoremap - mappings should apply to Visual mode, but not to Select mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

" Search for the current selection
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" " Search for the current selection
" :vmap n y/<C-R>"<CR>


" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>


command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


" Execute ctags
" nnoremap <f5> :!ctags -R<CR>
nnoremap <f5> :!ctags -R --exclude=.git --exclude=log *<CR>

" Automatically execute ctags each time a file is saved
" autocmd BufWritePost * call system("ctags -R")


" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>rf :call RenameFile()<cr>



" Promote variable to RSpec let
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>e :PromoteToLet<cr>


function! ExtractVar()
  normal ^*``
  normal ww
  normal "zDdd``
  normal cwz
endfunction
map ,gt :call ExtractVar()<cr>


" disable arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux & Turbux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:no_turbux_mappings = 1
map <leader>t <Plug>SendTestToTmux
map <leader>T <Plug>SendFocusedTestToTmux
map <leader>at :call VimuxRunCommand('bundle exec rspec --color') <cr>

let g:turbux_command_prefix = 'bundle exec' " default: (empty)
" let g:turbux_command_rspec  = 'spec'        " default: rspec
let g:turbux_command_test_unit = 'ruby'     " default: ruby -Itest
let g:turbux_command_cucumber = 'cucumber --drb --require features '  " default: cucumber
let g:turbux_command_turnip = 'rspec'       " default: rspec -rturnip

let g:VimuxHeight = "55"
let g:VimuxOrientation = "h"

" Prompt forca command to run
map <leader>rp :PromptVimTmuxCommand<cr>

" Run last ccmmand executed by RunVimTmuxCommand
map <leader>rl :RunLastVimTmuxCommand<cr>

" Inspect runner pane
map <leader>ri :InspectVimTmuxRunner<cr>

" Close all other tmux panes in current window
map <leader>rc :CloseVimTmuxPanes<cr>

" Interrupt any command running in the runner pane
map <leader>rs :InterruptVimTmuxRunner<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let g:vroom_use_bundle_exec = 0 " don't use bundle exec
let g:vroom_spec_command = 'spring rspec'
let g:vroom_map_keys = 0
map <unique> <Leader>rr :VroomRunTestFile<CR>
map <unique> <Leader>rR :VroomRunNearestTest<CR>
nmap <leader>ss :runtime! syntax/2html.vim<CR>
nmap <leader>E :!ruby %<CR>

let g:EasyMotion_leader_key = '<space>'
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
