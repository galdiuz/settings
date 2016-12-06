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
Plugin 'tpope/vim-fugitive'
Plugin 'craigemery/vim-autotag'
Plugin 'will133/vim-dirdiff'

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
set wildmenu
set wildmode=longest,full

" Toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Remove trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Line wrapping & Home to start of indent
autocmd VimEnter,BufReadPost * noremap  <buffer> <silent> <Up>   gk
autocmd VimEnter,BufReadPost * noremap  <buffer> <silent> <Down> gj
autocmd VimEnter,BufReadPost * noremap <Home> g^
autocmd VimEnter,BufReadPost * noremap <End> g<End>
autocmd VimEnter,BufReadPost * inoremap <buffer> <silent> <Up>   <C-o>gk
autocmd VimEnter,BufReadPost * inoremap <buffer> <silent> <Down> <C-o>gj
autocmd VimEnter,BufReadPost * inoremap <Home> <C-o>g^
autocmd VimEnter,BufReadPost * inoremap <End> <C-o>g<End>

" Tags
set tags=/var/www/tags,./tags;/,tags;/

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

" Autopairs settings
let g:AutoPairsShortcutFastWrap = 'đ'
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCenterLine = 0

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

" Folding
function! CustomFoldText()
    let currentLine = v:foldstart
    let lines = (v:foldend - v:foldstart + 1)
    let lineString = getline(currentLine)
    " See if we folded a marker
    if strridx(lineString, "{{{") != -1 " }}}
        " Is there text after the fold opener?
        if (matchstr(lineString, '^.*{{{..*$') == lineString) " }}}
            " Then only show that text
            let lineString = substitute(lineString, '^.*{{{', '', 'g') " }}}
            " There is text before the fold opener
        else
            " Try to strip away the remainder
            let lineString = substitute(lineString, '\s*{{{.*$', '', 'g') " }}}
        endif
        " See if we folded a DocBlock
    elseif strridx(lineString, '#@+') != -1
        " Is there text after the #@+ piece?
        if (matchstr(lineString, '^.*#@+..*$') == lineString)
            " Then show that text
            let lineString = substitute(lineString, '^.*#@+', '', 'g') . ' ' . g:phpDocBlockIncludedPostfix
            " There is nothing?
        else
            " Use the next line..
            let lineString = getline(currentLine + 1) . ' ' . g:phpDocBlockIncludedPostfix
        endif
        " See if we folded an API comment block
    elseif strridx(lineString, "\/\*\*") != -1
        " (I can't get search() or searchpair() to work.., therefore the
        " following loop)
        let s:state = 0
        while currentLine < v:foldend
            let line = getline(currentLine)
            if s:state == 0 && strridx(line, "\*\/") != -1
                " Found the end, now we need to find the first not-empty line
                let s:state = 1
            elseif s:state == 1 && (matchstr(line, '^\s*$') != line)
                " Found the line to display in fold!
                break
            endif
            let currentLine = currentLine + 1
        endwhile
        let lineString = getline(currentLine)
    endif

    " Some common replaces...
    " if currentLine != v:foldend
    let lineString = substitute(lineString, '/\*\|\*/\d\=', '', 'g')
    "let lineString = substitute(lineString, '^\*\?\s*', '', 'g')
    let lineString = substitute(lineString, '{$', '', 'g')
    let lineString = substitute(lineString, '($', '(..);', 'g')
    " endif

    " Append an (a) if there is PhpDoc in the fold (a for API)
    if currentLine != v:foldstart
        "let lineString = lineString . " " . g:phpDocIncludedPostfix . " "
    endif

    " Return the foldtext
    redir =>a |exe "sil sign place buffer=".bufnr('')|redir end
    let signlist=split(a, '\n')
    let width=winwidth(0) - ((&number||&relativenumber) ? &numberwidth : 0) - &foldcolumn - (len(signlist) > 2 ? 2 : 0)
    let lineCountStr = "[" . lines . " lines]"
    if strwidth(lineString) > width - strwidth(lineCountStr) - 1
        let lineString = strpart(lineString, 0, width - strwidth(lineCountStr) - 1) . '…'
    endif
    let expansionString = repeat(" ", width - strwidth(lineString.lineCountStr))

    return lineString.expansionString.lineCountStr
endfunction


augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd VimEnter,BufReadPost * set foldtext=CustomFoldText()
    "autocmd VimEnter *.php normal zR
augroup END " }
