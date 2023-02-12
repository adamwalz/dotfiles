-- "move highlighted" in visual mode
-- Uses the move command :m to move a highlighted region of text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- like "j", "J" takes the line below and appends it to current line with a space
-- but "J" allows your cursor to remain in the same place
vim.keymap.set("n", "J", "mzJ`z")

-- Half page jumping but keep cursor in the same place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allow search pattern to stay in the center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear search highlighting
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- formats a buffer using the attatched language server

-- quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- press <leader>s to replace all occurrences of the word you're currently hovering over
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Split line in insert mode
vim.keymap.set("i", "<C-c>", "<CR><Esc>O")

vim.keymap.set({ "n", "i" }, "<F1>", "<nop>") -- Unmap F1 help
vim.keymap.set("n", "Q", "<nop>") -- Don't ever get into Ex mode

-- Key repeat in visual mode
vim.keymap.set("v", ".", ":norm.<CR>")

vim.keymap.set("", "<F5>", ":setlocal spell! spelllang=en_us<CR>") -- If this changes, also change after/vimspector.lua
vim.keymap.set("i", "<F5>", "<ESC>:setlocal spell! spelllang=en_us<CR>")

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
