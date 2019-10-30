call plug#begin('~/.local/share/nvim/site/pack/plugged/start')

"" Aesthetics
" ------------------------------------------------------------------------------------------------------------
Plug 'arcticicestudio/nord-vim' 			    " Colorscheme
Plug 'vim-airline/vim-airline'  			    " Statusline
Plug 'ryanoasis/vim-devicons'   			    " Adds filetype glyphs
Plug 'junegunn/limelight.vim'   			    " Hyperfocus-writing


"" Functionalities
" ------------------------------------------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'		                " Git wrapper
Plug 'tpope/vim-sensible'		                " Defaults everyone can agree on
Plug 'majutsushi/tagbar'		                " Displays tags in a window, ordered by scope
Plug 'scrooloose/nerdtree'					    " File system explorer
Plug 'davidhalter/jedi-vim'                     " Jedi for Python
Plug 'Shougo/deoplete.nvim',                    " Asynchronous completion framework
            \ {'do': ':UpdateRemotePlugins'}
Plug 'deoplete-plugins/deoplete-jedi'           " Deoplete for Python
Plug 'ervandew/supertab'                        " Use <Tab> for all your insert completion needs
Plug 'jiangmiao/auto-pairs'                     " Insert or delete brackets, parens, quotes in pair
Plug 'Yggdroot/indentLine' 					    " Displaying vertical lines at each indentation level
Plug 'heavenshell/vim-pydocstring' 			    " Generator for Python docstrings
Plug 'qpkorr/vim-bufkill' 					    " Delete or wipe buffer without closing the window
Plug 'lervag/vimtex' 						    " Plugin for editing LaTeX files
Plug 'dense-analysis/ale' 					    " Check syntax in Vim asynchronously and fix files
Plug 'ntpeters/vim-better-whitespace' 		    " Better whitespace highlighting
Plug 'fisadev/vim-isort', {'for': 'python'}     " Sort python imports using isort
Plug 'airblade/vim-gitgutter' 				    " Shows a git diff in the gutter

call plug#end()


""" Coloring
" ------------------------------------------------------------------------------------------------------------
syntax on
color nord

" Opaque Background
set termguicolors


""" Other configurations
" ------------------------------------------------------------------------------------------------------------
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch wrapscan cpoptions+=x
set textwidth=110 wrap breakindent showbreak=..
set completeopt=noinsert,menuone,noselect
set updatetime=100
set encoding=utf-8
set shell=zsh\ -l
set noshowmode
set cursorline
set noshowcmd
set mouse=a
set confirm
set hidden
set number
set title

" Conda environment for neovim
let g:python3_host_prog = expand('~/.miniconda3/envs/neovim/bin/python')

" Git commit textwidth.
autocmd Filetype gitcommit setlocal spell textwidth=72

" Open NERDTree when vim start starts up with no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Quit VIM when NERDTree is the last active buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Enable spell checking
let g:myLanguage=0
let g:myLanguageList=["nospell","en_us","de_20"]
function! ToggleSpell()
        let g:myLanguage=g:myLanguage+1
        if g:myLanguage>=len(g:myLanguageList) | let g:myLanguage=0 | endif
        if g:myLanguage==0
           setlocal nospell
        else
	    execute "setlocal spell spelllang=".get(g:myLanguageList, g:myLanguage)
        endif
endfunction

" Disable Ruby support
let g:loaded_ruby_provider = 0

" Disable Node.js support.
let g:loaded_node_provider = 0

" Disable Python 2
let g:loaded_python_provider = 0

"Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
        au!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
augroup END

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-d> <Esc>:q<CR>
tmap <C-w><C-w> <Esc><C-w><C-w>
tmap <C-w><C-k> <Esc><C-w><C-k>
autocmd TermOpen term://* startinsert
autocmd BufEnter term://* startinsert


""" Plugin Configurations
" ------------------------------------------------------------------------------------------------------------

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'


" TagBar
let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['↠', '↡']

" NERDTree
let g:NERDTreeWinSize = 37
let g:NERDTreeMouseMode = 2
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 0
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeSortOrder = ['archive', 'ANN', 'SNN', 'LICENSE', 'README.md', 'environment.yml', 'hosts', 'srun', 'submit',
                        \'\.py', '*', 'data', 'utils', 'tests', 'models', 'results', 'scripts', '\/$']

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#yarp = 1

" Jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 2
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#enable_speed_debugging=0

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Indentline
let g:indentLine_char = '┊'
let g:vim_json_syntax_conceal = 0
let g:indentLine_color_gui = '#4C566A'
let g:indentLine_fileTypeExclude = ['tex']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
autocmd FileType tex set conceallevel=0

" Pydocstring
let g:pydocstring_templates_dir = '~/.pydocstring/templates'

" Vimtex
let g:vimtex_compiler_progname = expand('~/.miniconda3/envs/neovim/bin/nvr')

" Ale
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
let g:ale_use_global_executables = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['autopep8', 'isort', 'trim_whitespace']}
let g:ale_python_flake8_executable = expand('~/.miniconda3/envs/neovim/bin/flake8')
let g:ale_python_autopep8_executable = expand('~/.miniconda3/envs/neovim/bin/autopep8')
let g:ale_python_isort_executable = expand('~/.miniconda3/envs/neovim/bin/isort')
let g:ale_python_trim_whitespace_executable = expand('~/.miniconda3/envs/neovim/bin/trim_whitespace')

" Vim-better-whitespace
let g:better_whitespace_guicolor='#EBCB8B'
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', '']

" Gitgutter
let g:gitgutter_max_signs=9999


""" Custom Mappings
" ------------------------------------------------------------------------------------------------------------
let mapleader=","
nmap <leader>l :Limelight!!<CR>
xmap <leader>l :Limelight!!<CR>
nmap <silent><leader>w :TagbarToggle<CR>
nmap <silent><leader>q :NERDTreeToggle<CR>
nmap <silent><leader>c <C-w>s<C-w>j:resize 15 \| :set nocursorline \| :terminal<CR>
nmap <leader>ds <Plug>(pydocstring)
nmap <silent><leader>s :call ToggleSpell()<CR>
nmap <silent><leader>gs :split \| resize -20 \| Gedit :<CR>
nmap <silent><leader><leader> :noh<CR>
nnoremap  <silent>   <tab>  :bn<CR>
nnoremap  <silent> <s-tab>  :bp<CR>
