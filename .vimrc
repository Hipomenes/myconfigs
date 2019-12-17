           _    _ _     __   _____ __  __ ___  ___
"|   \ __ ___ _(_)__| ( )___ \ \ / |_ _|  \/  | _ \/ __|
"| |) / _` \ V | / _` |/(_-<  \ V / | || |\/| |   | (__
"|___/\__,_|\_/|_\__,_| /__/   \_/ |___|_|  |_|_|_\\___|
"                                                  2019

set runtimepath+=~/.vim_runtime

"Installs Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

set autoread   " auto read files changed outside vim    

"Turns off spell-checking at a general level
set nospell

"Turns off spell checking in Markdown files
let g:pandoc#spell#enabled = 0

"Vim-Pandoc Configs
let g:pandoc#syntax#conceal#use = 1
let g:pandoc#syntax#conceal#blacklist = ["atx","codeblock_start","codeblock_delim","footnote","quotes","image","superscript","subscript","list","emphasis"]
let g:pandoc#syntax#conceal#urls = 1

"Syntax Highlighting 
syntax enable

"Disables matching paren highliting, tht seems to slow things down 
autocmd VimEnter * NoMatchParen

"Something to do with Vim's Regex. Suposedly makes it faster.
set re=1 

"Add FZF support 
set rtp+=/usr/local/opt/fzf

"ACK uses the Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

"Seoul256 Unified color scheme (default: dark)
""colo seoul256
colo gruvbox

"Editor Attributes
set number
set norelativenumber
set isfname-=:

"Keymaping for quicker change between Insert and Normal modes
inoremap jj <esc>

"Quickly delete a word
:cmap << diw

"Insert Unicode Right Arrow
inoremap >> →

"Keymapings for bracket autocompletion (De-supported because of issues with slower typing within brackets and parenthesis)
:inoremap ( ()<Esc>i
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap { {}<Esc>i
:inoremap * **<Esc>i
:inoremap ` ``<Esc>i

" Gets rid of the annotying sudo write (:W)
:cmap WQ wq
:cmap W w

" VIM TYPEWRITER MODE



"========DHC's A Poor Man's Wiki====================================================
" gf - This good old Vim command opens the file name under the cursor in a new tab.
" Autocomplete relative file name: in insert mode, use <C-x> <C-f> to link to an existing file in the path.
" The following keybinding creates a new file named after the text under the cursor.
" noremap gf :e <cfile><.md<CR> " This should open a new buffer with a filename without extension, assuming that it is an .md

"This clever command of my own making creates a new file and adds the extension of the current file, which makes sense for a wiki. 
"And it has an unexpected exaptive functionality: it creats a bibtex key (@source - hence the 's') as a file, 
"so it would open the file that looks like it.  

:set suffixesadd+=.md
noremap gS :e <cfile><.%:e<CR>

" This crucial command complemetes VIM's native two great commands:
" gf - opens file in a split
" gF - opens file AND GOES to file line in new window - the possibilities of this are endless 
" In order to work, the correct syntax is the following: file-name.ext :line-num (eg. week.md :23)
"
" Todo- Implement tag navigation. The idea is to use verbatim inline blocks in camel-case as tags (`NativeExegesis`), and to produce a tag file
"using ctags and the appropriate regex expression for verbatim blocks. Using camel-case tags has two extra advantages: first
"markdown syntax highlights them (reproducing a bit my color-code for concepts) and secondly, the camel-case can be defined
"as a VIM text object, which opens a further possibility I have not yet explored. - IDEA DEPRECATED IN FAVOR of A SIMPLE OVER-CURSOR GREP

"A Better Alternative 
" Does a grep search for word under cursor and puts in the quick fix window
" bind K to grep word under cursor (Not functioning yet, though)

"nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nnoremap K :Ag "<C-R><C-W>"<CR>:cw<CR> / %

"Search and Fuzzy-Find (way better than NvAlt, finally!)

" Fuzzy-file names with FZF
nnoremap <C-p> :Files ~/Documents/nvdata/<Cr>

" Fuzzy-find text in files with FZF, which technically uses AG)
" (This is rather confusing, for even though it is called Ag, it is in fact passed through FZF
" nnoremap <C-n> :Ag ~/Documents/nvdata/<Cr>

"Search word under the cursor with :Ack (using The Silver Searcher, ag) and no Fuzzy Finding
nnoremap <C-k> :Ack -i <C-R><C-W><CR> ~/Documents/nvdata/

"Creates a David's Wiki link wrapper around the last two words.
nnoremap ,wl <esc>2bi[[<esc>f<space>r-ea.md]]
nnoremap ,wg <esc>2bi[[<esc>f<space>r-ea.md]]<esc>4b :e <cfile><.%:e<CR>

"=================================================================================


"Sets my bibtex bibliography
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ['/Users/davidcolmenares/Documents/mylibraries/zoterotesis.bib']

"My dictionary of words for auto-completion
"set complete+=k~/.vim/keywords.txt

"Remove level-three headings (before priting a draft)
"Nemotechnique, delete headings
map ,dh :g/^###/d<CR>

"Goyo plugin makes text more readable when writing prose:
map ,f :Goyo \| set linebreak<CR>

" Spell-check
map ,e :setlocal spell! spelllang=en_us<CR>
map ,ñ :setlocal spell! spelllang=es <CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

"Text place-holder syntax coloring  
match Error '{\w\+}'

"Collects all text place-holders in VIM's quickfix buffer 
"nnoremap ,e{ :vimgrep /{\w\+}/ %<CR>:copen<CR>

"Vim-Jekyll Blog Pluggin
let g:jekyll_path = "/Users/davidcolmenares/Documents/hipomenes.github.io/"
map ,np :JekyllPost<CR>

"Outlining Mode
"autocmd BufEnter,BufNew *.out set smartindent foldmethod=indent expandtab tw=0 ts=4 sw=4 spell

"Startify - DHC IRE's

let g:startify_bookmarks = [ {'d': '~/Documents/nvdata/bitacora-verano-2019.md'}, {'T': '~Documents/nvdata/indes-diss-general.md'}, {'w': '~/Documents/nvdata/WEEK.md'} ]

let g:startify_session_dir = '~/.vim/sessions'

let g:startify_fortune_use_unicode = 1
map ,s :Startify <CR>

"I use the hand Vim-Seak, that uses 's' as a more precise subtitute for f/t by taking to letters instead of one
"The plugin uses `s` and `S` for this, but they can be remaped to diferent keybindings thus:
"(See also https://github.com/goldfeld/vim-seek for more keys)
"let g:SeekKey = '<Space>'
"let g:SeekBackKey = '<S-Space>'=

" Spell-Checking Mode (simply uncomment)
noremap ¡ ]s
noremap ' [s
noremap º z=
noremap zz 1z=

try
source ~/.vim_runtime/my_configs.vim
catch
endtry
