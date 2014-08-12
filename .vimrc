"""""" COLORSCHEMES """"""

" Show unwanted whitespace on leaving insert-mode
" MUST be inserted BEFORE colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color Scheme Wombat : for 256 color xterms created by David Liang
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod



""""" vim functions """"""

" Indent automatically depending on filetype
filetype off
filetype plugin indent on
set autoindent

" Set syntax on + search options
syntax on
set ignorecase   " Case insensitive search
set hlsearch  " Higlhight search
set incsearch " To move the cursor to the matched string, while typing the search pattern
set smartcase " if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not

" enable pastetogle (Then the existing indentation of the pasted text will be retained.)
set pastetoggle=<F2>

" Showing line numbers and length and some more programming environment stuff
set number   " show line numbers
set tw=79    " width of document (used by gd)
set nowrap   " don't automatically wrap on load
set fo-=t    " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Real programmers don't use TAB's but spaces
"  you want to enter a real tab character use Ctrl-V<Tab> key sequence.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


""""" remapping """""

" copy to clipboard
vnoremap <Leader>c "+y

" remove highlight after search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" moving blocks and retain the selection
vnoremap < <gv
vnoremap > >gv



""""" PLUGINS """"""""

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
