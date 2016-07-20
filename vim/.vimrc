set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'scrooloose/syntastic'
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'tobyS/vmustache'
"Bundle 'tobyS/pdv'
Plugin 'sumpygump/php-documentor-vim'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'gcmt/taboo.vim'
Plugin 'rayburgemeestre/phpfolding.vim'
Plugin 'ntpeters/vim-better-whitespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"==========
" SETTINGS
"==========

filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set noswapfile
"set foldlevelstart=0

" Toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Remove trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Line wrapping & Home to start of indent
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap <Home> g^
noremap <End> g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <Home> <C-o>g^
inoremap <End> <C-o>g<End>

"=================
" PLUGIN SETTINGS
"=================

" Netrw settings
map <C-e> :Rexplore<CR>
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_alto=1

" Closetags settings
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

" PHP Documentor settings
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR>
let g:pdv_cfg_ClassTags = ["author", "copyright"]
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = ""
let g:pdv_cfg_Author = "   Webbhuset AB <info@webbhuset.se>"
let g:pdv_cfg_Copyright = "Copyright (C) 2016 Webbhuset AB"
let g:pdv_cfg_License = ""

" Syntastic settings
let g:syntastic_check_on_open = 1

" Taboo settings
set sessionoptions+=tabpages,globals
let g:taboo_tab_format=" %m%N: %f(%W) "
let g:taboo_renamed_tab_format=" %m%N: %l(%W) "
