" General settings
let mapleader = "," " map leader to comma

set guicursor=i:block " set insert cursor to block

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

set autoindent " indent nl the same amount as the line typed
set smartindent " do smart autoindenting when starting a new line

set hidden " hide buffer instead of closing

set number relativenumber " turn hybrid line numbers on
set nu rnu

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set cursorline! cursorcolumn!

set tabstop=3				  " the number of columns occupied by a tab
set softtabstop=0 noexpandtab " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=3 			  " indent corresponds to single tab

set colorcolumn=80 " set 80-column inditcation

" Plugins using vim-plug
" NOTE: toggleterm conflicts with NeoVim < v0.7

call plug#begin()
	Plug 'mhinz/vim-startify'

	Plug 'preservim/tagbar'
	Plug 'Yggdroot/indentLine'
	Plug 'morhetz/gruvbox'
	Plug 'sainnhe/gruvbox-material'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'cespare/vim-toml', { 'branch': 'main' }

	Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

	Plug 'lervag/vimtex'

	Plug 'rust-lang/rust.vim'

	Plug 'tpope/vim-surround'
	Plug 'airblade/vim-gitgutter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'kyazdani42/nvim-web-devicons' 
	Plug 'lewis6991/impatient.nvim'
	Plug 'rcarriga/nvim-notify'

	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-telescope/telescope-file-browser.nvim'

	Plug 'folke/zen-mode.nvim'
	Plug 'folke/twilight.nvim'


call plug#end()

" Plugin settings

"" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.colnr = ' ℅:'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ' :'
" let g:airline_symbols.maxlinenr = '☰ '
" let g:airline_symbols.dirty='⚡'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='catppuccin'

"" coc
" Disable startup warning
let g:coc_disable_startup_warning = 1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" indentLine
let g:indentLine_setColors = 0

let g:indentLine_char = '│'

"" Telescope
lua << EOF
require('telescope').setup{
  -- ...
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
EOF



"" toggleterm
lua << EOF
require("toggleterm").setup{
	open_mapping = [[<Leader>t]],
	insert_mappings = false,
	terminal_mappings = true,
	shade_terminals = false,
}
EOF

"" twilight
lua << EOF
  require("twilight").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

"" vimtex
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

"" change build directory
"let g:vimtex_compiler_latexmk = {
"	\ 'build_dir' : './target/',
"	\}

" Use xelatex to compile
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \}

" map local leader to same as mapleader
let maplocalleader = ","

"" zen mode
lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" Theme
colorscheme catppuccin-macchiato
"autocmd BufEnter *.tex colorscheme catppuccin-latte 
set termguicolors
hi Normal guibg=NONE ctermbg=NONE

syntax on " syntax highlighting
filetype plugin indent on

" Functions

" Keymaps

"" General
" center cursor
nnoremap j jzz
nnoremap k kzz

" exit insert mode
inoremap jk <ESC>
inoremap § <ESC>

" exit Vim with ESC
nnoremap <ESC> :q<CR>

" write buffer
nnoremap <leader>s :w<CR>
" Unload current buffer 
nnoremap <Leader>q :bd<CR>

"" coc
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use enter for autocomplete
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" land cursor between brackets
 inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Restart Coc
nmap <leader>r :CocRestart<CR>

"" tagbar
nmap <leader>b :TagbarToggle<CR>

"" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"" vimtex
nmap <leader>wc :VimtexCountWords<CR> 

"" zenmode
nnoremap <leader>z :ZenMode<CR>
