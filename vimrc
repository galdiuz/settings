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
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tmhedberg/matchit'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jparise/vim-graphql'
Plugin 'neo4j-contrib/cypher-vim-syntax'
Plugin 'ElmCast/elm-vim'
"Plugin 'tpope/vim-vinegar'
Plugin 'Shougo/defx.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

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
"set relativenumber
set noswapfile
set wildmenu
set wildmode=longest,full
set ignorecase
set smartcase
set list
set listchars=tab:>-

" Status line
set laststatus=2                             " always show statusbar
set statusline=
set statusline+=%-5.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%{&bomb?'[BOM]':''}          " BOM flag
set statusline+=%h%m%r%w                     " status flags
"set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position
set modelines=0
set nomodeline

" Toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
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

" Autocorrect
iabbrev consolidaiton consolidation

" Dahbug
nmap <F3>dd o\dahbug::dump();<ESC>hi
imap <F3>dd \dahbug::dump();<ESC>hi
nmap <F3>dp o\dahbug::dump();<ESC>hPll
imap <F3>dp \dahbug::dump();<ESC>hPlla
nmap <F3>mm o\dahbug::methods();<ESC>hi
imap <F3>mm \dahbug::methods();<ESC>hi
nmap <F3>mp o\dahbug::methods();<ESC>hPll
imap <F3>mp \dahbug::methods();<ESC>hPlla
nmap <F3>tt o\dahbug::toggleTimer();<ESC>hi
imap <F3>tt \dahbug::toggleTimer();<ESC>hi
nmap <F3>tp o\dahbug::toggleTimer();<ESC>hPll
imap <F3>tp \dahbug::toggleTimer();<ESC>hPlla


"=================
" PLUGIN SETTINGS
"=================

" Netrw
"map <C-e> :Rexplore<CR>
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_alto=1
autocmd FileType netrw setl bufhidden=delete

" Closetags
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

" Autopairs settings
let g:AutoPairsShortcutFastWrap = 'đ'
let g:AutoPairsShortcutToggle = 'ŋ'
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCenterLine = 0
"au Filetype php call AutoPairsDefine({'<?=' : '?>'}, ['<?', '<?php'])

" PHP Documentor
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
let g:pdv_cfg_ClassTags = ["author", "copyright"]
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = ""
let g:pdv_cfg_Author = "   Webbhuset AB <info@webbhuset.se>"
let g:pdv_cfg_Copyright = "Copyright (C) 2018 Webbhuset AB"
let g:pdv_cfg_License = ""

" Elm-vim
autocmd FileType elm setlocal foldmethod=syntax

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_rst_checkers = ['sphinx']

" Taboo
set sessionoptions+=tabpages,globals
let g:taboo_tab_format=" %m%N: %f(%W) "
let g:taboo_renamed_tab_format=" %m%N: %l(%W) "

" Easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_verbose = 0
let g:EasyMotion_skipfoldedline = 0
let g:EasyMotion_enter_jump_first = 1

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map ? <Plug>(easymotion-sn)
omap ? <Plug>(easymotion-tn)

nmap f <Plug>(easymotion-fl)
vmap f <Plug>(easymotion-fl)
nmap F <Plug>(easymotion-Fl)
vmap F <Plug>(easymotion-Fl)

nmap t <plug>(easymotion-tl)
vmap t <plug>(easymotion-tl)
nmap T <plug>(easymotion-Tl)
vmap T <plug>(easymotion-Tl)

nmap w <plug>(easymotion-w)
vmap w <plug>(easymotion-w)
nmap W <plug>(easymotion-W)
vmap W <plug>(easymotion-W)

nmap b <plug>(easymotion-b)
vmap b <plug>(easymotion-b)
nmap B <plug>(easymotion-B)
vmap B <plug>(easymotion-B)

nmap e <plug>(easymotion-e)
vmap e <plug>(easymotion-e)
nmap E <plug>(easymotion-E)
vmap E <plug>(easymotion-E)

nmap ge <plug>(easymotion-ge)
vmap ge <plug>(easymotion-ge)
nmap gE <plug>(easymotion-gE)
vmap gE <plug>(easymotion-gE)

nmap n <plug>(easymotion-n)
vmap n <plug>(easymotion-n)
nmap N <plug>(easymotion-N)
vmap N <plug>(easymotion-N)

" Defx

nnoremap <silent> - :Defx -resume -toggle<CR>

autocmd VimEnter * command! -nargs=? Explore :Defx <args>
autocmd VimEnter * command! -nargs=? Texplore :Defx -split=tab -resume=1 <args>
autocmd VimEnter * command! -nargs=? -bang Vexplore call SplitDefx('vnew', <bang>0, <f-args>)
autocmd VimEnter * command! -nargs=? -bang Hexplore call SplitDefx('new', <bang>1, <f-args>)

function! SplitDefx(split, bang, ...)
    let com = a:split . " | Defx -resume " . get(a:, 1, "")

    if a:bang
        let com = "below " . l:com
    endif

    execute l:com
endfunction

autocmd FileType defx setlocal cursorline
autocmd FileType defx call defx#custom#column('filename', 'min_width', 60)
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> %
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> D
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

"=================
" FOLDING
"=================
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

"=================
" ALIGN EQUALS
"=================

function! AlignEqualsRange() range
    let lineStart   = line("'<")
    let lineEnd     = line("'>")
    let equalsCol   = 0

    for i in range(lineStart, lineEnd)
        let col = stridx(getline(i), "=")
        if col > equalsCol
            let equalsCol = col
        endif
    endfor

    if &shiftwidth > 0
        let equalsCol += (&shiftwidth - (equalsCol % &shiftwidth)) % &shiftwidth
    endif

    for i in range(lineStart, lineEnd)
        let lineString      = getline(i)
        let col             = stridx(lineString, "=")
        let spaces          = equalsCol - col
        let lineStringEnd   = strpart(lineString, col)
        let lineString      = strpart(lineString, 0, col)
        let j               = 0
        while j < spaces
            let lineString .= " "
            let j += 1
        endwhile
        let lineString .= lineStringEnd
        call setline(i, lineString)
    endfor
endfunction

vnoremap <F4> :call AlignEqualsRange()<CR>

"=================
" RELOAD
"=================
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd VimEnter,BufReadPost * set foldtext=CustomFoldText()
    "autocmd VimEnter *.php normal zR
augroup END " }
