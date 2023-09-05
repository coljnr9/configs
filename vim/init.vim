" From ChatGPT

" Specify the runtime path to include plugins.
call plug#begin('~/.config/nvim/plugged')

" Plug 'repository/plugin', {'option': 'value'} format for installing plugins.
" Note: Run :PlugInstall in Vim to actually install these plugins.

" Vim enhancements
Plug 'itchyny/lightline.vim'
Plug 'andymass/vim-matchup'

" Telescope + deps
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }


" Rust
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ansible
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}

" Fuzzy finding in files.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Dracula theme.
Plug 'Mofiqul/dracula.nvim'

" Line limit hint.
Plug 'Yggdroot/indentLine'

" Comment out code
Plug 'tpope/vim-commentary'

" Vim code screenshotter
Plug 'SergioRibera/vim-screenshot', { 'do': 'npm install --prefix Renderizer' }

" Initialize the plugin system.
call plug#end()

" Theme Setting.
" Load the dracula theme.
colorscheme dracula

" General Configurations
set relativenumber            " Display line numbers
set tabstop=4                 " A tab is four spaces
set shiftwidth=4              " Number of spaces to use for autoindent
set expandtab                 " Use spaces instead of tabs
set smartindent               " Smart autoindenting when starting a new line

" Set a line-length hint
set colorcolumn=100

" Turn on spell checking - mostly for comments
set spell spelllang=en_us

" Coc.nvim Configuration
" Let g:coc_global_extensions be a list of extensions to be installed
let g:coc_global_extensions = [
    \ 'coc-pyright',
    \ 'coc-pairs',
    \ 'coc-rust-analyzer',
    \ 'coc-yaml',
    \ ]

set updatetime=300
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Find files using Telescope command-line sugar.
" From the telescope github README
nnoremap <leader>ff <cmd>Telescope find_files prompt_prefix=🔍<cr>
nnoremap <leader>fg <cmd>Telescope live_grep prompt_prefix=🔍<cr>
nnoremap <leader>fb <cmd>Telescope buffers prompt_prefix=🔍<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Apply code suggestions (I think Coc?)
" From the coc guithub readme

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)


" FZF Configuration
" Enable per-command history.
" CTRL-N/P (or down/up) to navigate through command history
" CTRL-A/Z to go to the start/end of history.
" Enter to select, CTRL-C/CTRL-G/ESC to cancel.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" fzf should seach w/in (most) hidden dirs
command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" IndentLine Configuration
let g:indentLine_char = '│'
let g:indentLine_showFirstIndentLevel = 0
" 100 column limit.
let g:indentLine_color_term = 239
let g:indentLine_conceallevel = 0
let g:indentLine_concealplus = 1
let g:indentLine_setColors = 0
autocmd BufRead,BufNewFile * let w:indentLine_basechar = repeat(' ', 100)

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

