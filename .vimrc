" COLORSCHEMES {{{1

" Show unwanted whitespace on leaving insert-mode
" MUST be inserted BEFORE colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color Scheme Wombat : for 256 color xterms created by David Liang
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set background=dark
set t_Co=256           " set 256 colors
color wombat256mod

" VIM FUNCTIONS {{{1

" Indent automatically depending on filetype
filetype off
filetype plugin indent on
set autoindent
set nocompatible  " => better safe than sorry?

" Set syntax on + search options
syntax on
set ignorecase   " Case insensitive search
set hlsearch  " Higlhight search
set incsearch " To move the cursor to the matched string, while typing the search pattern
set smartcase " if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not

" enable pastetogle (Then the existing indentation of the pasted text will be retained.)
set pastetoggle=<F2>
set paste
" set paste  " disable set paste for jedi-vim, ctrl-space doesn't work for jedi-vim

" Showing line numbers and length and some more programming environment stuff
set number              " show line numbers
set textwidth=79        " width of document (used by gd)
set nowrap              " don't automatically wrap on load
set formatoptions-=t    " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Real programmers don't use TAB's but spaces
"  you want to enter a real tab character use Ctrl-V<Tab> key sequence.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set encoding=utf-8
set list
set listchars=tab:▸\ ,eol:¬

set foldmethod=marker

" Backup/Swap/Undo stuff
set backup
set noswapfile

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif



""""" remapping """"" {{{1

" give colors to the indent blocks
nnoremap <leader>B :call BlockColor()<cr>

" copy text until next space to clipboard
" to be improved : space||tab||enter
noremap <Leader>cl vf<Space>"+y

" see indent guidlines
nnoremap <leader>I :call IndentGuides()<cr>

" function to Highlight words... see in Function section
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" function to highlight certain selection in vmode
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" remove highlight after search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Resize splits
nnoremap <C-h> 5<C-w><
nnoremap <C-l> 5<C-w>>
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-
" Jump between splits faster
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j


" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Keep search matches in the middle of the window when searching next or previous
nnoremap n nzzzv
nnoremap N Nzzzv

" moving blocks and retain the selection
vnoremap < <gv
vnoremap > >gv

" Toggle paste
" For some reason pastetoggle doesn't redraw the screen in nmode?
" (thus the status bar doesn't change) while :set paste! does
" set pastetoggle=<F2> used for imode
nnoremap <F2> :set paste!<cr>

" Toggle [i]nvisible characters
nnoremap <F5> :set list!<cr>

" Quick Editing
nnoremap <Leader>eeg :split /etc/group
nnoremap <Leader>eeh :split /etc/hosts

cmap w!! w !sudo tee > /dev/null %



""""" au """"" {{{1

" Resize splits when the window is resized
au VimResized * :wincmd =



""""" augroup """"" {{{1

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

""""" abreviations """"" {{{1
inoreabbrev aag@ aldwinaldwin@gmail.com
inoreabbrev aah@ aldwinaldwin@hotmail.com



""""" PLUGINS """""""" {{{1

" Pathogen : to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"github.com/tpope/vim-pathogen
" now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

" Settings for vim-powerline
" cd ~/.vim/bundle    ///pathogen install
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2



"""""" FUNCTIONS """"" {{{1

" Highlight Word
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.
"
function! HiInterestingWord(n)
    " Save our location.
    normal! mz
    " Yank the current word into the z register.
    normal! "zyiw
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)
    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'
    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    " Move back to our original location.
    normal! `z
endfunction
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" Visual Mode */# from Scrooloose
"
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" Indent Guides
"
let g:indentguides_state = 0
function! IndentGuides()
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction
hi def IndentGuides guibg=#303030 ctermbg=233

" Block Colors
"
let g:blockcolor_state = 0
function! BlockColor()
    if g:blockcolor_state
        let g:blockcolor_state = 0
        call matchdelete(77881)
        call matchdelete(77882)
        call matchdelete(77883)
        call matchdelete(77884)
        call matchdelete(77885)
        call matchdelete(77886)
    else
        let g:blockcolor_state = 1
        call matchadd("BlockColor1", '^ \{4}.*', 1, 77881)
        call matchadd("BlockColor2", '^ \{8}.*', 2, 77882)
        call matchadd("BlockColor3", '^ \{12}.*', 3, 77883)
        call matchadd("BlockColor4", '^ \{16}.*', 4, 77884)
        call matchadd("BlockColor5", '^ \{20}.*', 5, 77885)
        call matchadd("BlockColor6", '^ \{24}.*', 6, 77886)
    endif
endfunction
hi def BlockColor1 guibg=#222222 ctermbg=234
hi def BlockColor2 guibg=#2a2a2a ctermbg=235
hi def BlockColor3 guibg=#353535 ctermbg=236
hi def BlockColor4 guibg=#3d3d3d ctermbg=237
hi def BlockColor5 guibg=#444444 ctermbg=238
hi def BlockColor6 guibg=#4a4a4a ctermbg=239



