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
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }


" Rust
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ansible
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}


" Fuzzy finding in files.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'airblade/vim-rooter'

" Dracula theme.
Plug 'Mofiqul/dracula.nvim'

" Line limit hint.
Plug 'Yggdroot/indentLine'

" Comment out code
Plug 'tpope/vim-commentary'

" Vim code screenshotter
Plug 'SergioRibera/vim-screenshot', { 'do': 'npm install --prefix Renderizer' }

" Neoscroll
Plug 'karb94/neoscroll.nvim'

" Leap
Plug 'ggandor/leap.nvim'

" Fugitive
Plug 'tpope/vim-fugitive'

" Hardtime
Plug 'm4xshen/hardtime.nvim'

Plug 'tpope/vim-surround'
" Initialize the plugin system.

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Oil
Plug 'stevearc/oil.nvim'
    
call plug#end()

" Theme Setting.
" Load the dracula theme.

" General Configurations
set number                    " Display current line number
set relativenumber            " Display relative line numbers

set tabstop=4                 " A tab is four spaces
set shiftwidth=4              " Number of spaces to use for autoindent
set expandtab                 " Use spaces instead of tabs
set smartindent               " Smart autoindenting when starting a new line

set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵ " Better highlighting for white-space
set list

" Don't show mode using nvim (lightline takes care of this)
set noshowmode
set cursorline
" Set list chars to something more visible (comment color)
highlight NonText guifg=#6272a4

" Set a line-length hint
set colorcolumn=100

" Break line at predefined characters
set linebreak
set showbreak=↪

" Turn on spell checking - mostly for comments
set spell spelllang=en_us

let mapleader = "\<Space>"

" Coc.nvim Configuration
" Let g:coc_global_extensions be a list of extensions to be installed
let g:coc_global_extensions = [
    \ 'coc-pyright',
    \ 'coc-pairs',
    \ 'coc-rust-analyzer',
    \ 'coc-yaml',
    \ ]


" Lightline configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode',  'paste' ],
      \             [ 'cocfunc','readonly', 'filen'] ],
      \   'right': [['gitbranch', 'filetype', 'pos']]
      \ },
      \ 'component': {
      \   'helloworld': 'test component!',
      \   'filen': '%t',
      \   'pos': '%l/%L'
      \ },
      \ 'component_function': {
              \ 'gitbranch': 'FugitiveHead',
              \ 'cocfunc': 'CocCurrentFunction'
            \ }
      \ }
autocmd User CocStatusChange,CocDiagnosticChange let b:coc_current_function = get(b:, 'coc_current_function', '')
function! CocCurrentFunction() 
    return get(b:, 'coc_current_function', '')
endfunction

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
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
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
nnoremap <leader>ff <cmd>Telescope find_files prompt_prefix=🔍 path_display={"truncate"}<cr>
nnoremap <leader>fg <cmd>Telescope live_grep prompt_prefix=🔍 path_display={"truncate"}<cr>
nnoremap <leader>fs <cmd>Telescope grep_string prompt_prefix=🔍 path_display={"truncate"}<cr>
nnoremap <leader>fb <cmd>Telescope buffers prompt_prefix=🔍 path_display={"truncate"}<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>s  :<C-u>CocList symbols<cr>


" Use Ctrl + direction to move between windows/tabs/etc
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l


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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent><nowait> <leader>e :edit .<cr>
nnoremap <silent><nowait> <leader><leader> :b#<CR>

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


" Scrolling improvements
" From here https://blog.theodorc.no/posts/top5-nvim-plugins/
nmap("<C-u>", "<C-u>zz");
nmap("<C-d>", "<C-d>zz");
lua require('neoscroll').setup()

" Leap
lua require('leap').add_default_mappings()

" Hardtime
lua require('hardtime').setup()

" Treesitter
" https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "rust", "lua", "yaml", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF

" Oil
lua require("oil").setup()

colorscheme dracula
