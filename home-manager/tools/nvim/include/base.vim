let mapleader="\<SPACE>"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <leader>xx <cmd>TroubleToggle<cr>

set rnu
set number "Hybrid line numbers!!11
set showmatch
set shiftwidth=4
set splitbelow
set splitright
set termguicolors
set hidden

filetype plugin on

set background=dark
colorscheme PaperColor
hi BufferInactive guifg=White
