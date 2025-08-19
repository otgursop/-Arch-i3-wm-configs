" ========================
" Basic Settings
" ========================
set encoding=UTF-8
set number
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
syntax enable
filetype plugin indent on
set completeopt=menuone,noinsert,noselect
set clipboard=unnamedplus
set termguicolors

" ========================
" Plugin Manager: vim-plug
" ========================
call plug#begin('~/.local/share/nvim/plugged')

" UI
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

" Color themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim'

" Utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'mg979/vim-visual-multi'
Plug 'preservim/tagbar'

" File Explorer
Plug 'nvim-neo-tree/neo-tree.nvim', {'branch': 'v3.x'}
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP Setup 
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'           
Plug 'williamboman/mason-lspconfig.nvim' 

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

" ========================
" Color Scheme
" ========================
colorscheme iceberg

" ========================
" Plugin Settings (Lua)
" ========================

" Neo-Tree File Explorer
lua << EOF
require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
        },
    },
    window = {
        width = 30,
    },
})
EOF

" Treesitter: Better syntax highlighting
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "python", "lua", "bash" },
  highlight = {
    enable = true,
  },
}
EOF

" LSP: Setup with Mason and clangd
lua << EOF
-- Setup Mason
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "clangd" },
})

-- Function to run when LSP attaches to a buffer
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- Keybindings for LSP features 
  nmap('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code action')
  nmap('gd', require("telescope.builtin").lsp_definitions, 'Go to definition')
  nmap('gr', require("telescope.builtin").lsp_references, 'Show references')
  nmap('K', vim.lsp.buf.hover, 'Hover documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
end

-- Configure clangd for C/C++
require('lspconfig').clangd.setup {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  single_file_support = true,
  -- Capabilities:  
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
}
EOF

" ========================
" Keybindings
" ========================
nnoremap <F8> :TagbarToggle<CR>           " Toggle Tagbar (code outline)

nnoremap <C-t> :Neotree toggle<CR>        " Toggle file explorer

nnoremap <C-z> :tabnew<CR>                " New tab
nnoremap <C-x> :tabclose<CR>              " Close tab
nnoremap <C-h> :tabprevious<CR>           " Previous tab
nnoremap <C-l> :tabnext<CR>               " Next tab

tnoremap <Esc><Esc> <C-\><C-n>            " Exit terminal mode
