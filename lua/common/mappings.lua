vim.keymap.set("n", "<esc>", ":nohl<CR>", { desc = "HIDDEN HIGHTLIGHT SELECTION", silent = true })
-- Move focus among windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "MOVE FOCUS TO THE LEFT WINDOW" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "MOVE FOCUS TO THE RIGHT WINDOW" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "MOVE FOCUS TO THE LOWER WINDOW" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "MOVE FOCUS TO THE UPPER WINDOW" })

-- Split window
vim.keymap.set("n", "\\", ":split<CR>", { desc = "SPLIT WINDOW HORIZONTAL" })
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "SPLIT WINDOW VERTICAL" })

-- Move line
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "MOVE LINE DOWN IN INSERT MODE" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "MOVE LINE UP IN INSERT MODE" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "MOVE LINE DOWN IN NORMAL MODE" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "MOVE LINE UP IN NORMAL MODE" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv-gv", { desc = "MOVE LINE DOWN IN VISUAL MODE" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv-gv", { desc = "MOVE LINE UP IN VISUAL MODE" })

-- Better indent visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent LEFT" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent RIGHT" })

-- Resize window
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "INCREASE HEIGHT" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "DECREASE HEIGHT" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "DECREASE WIDTH" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "INCREASE WIDTH" })

-- Buffer
vim.keymap.set("n", "]b", ":bnext<cr>", { desc = "NEXT BUFFER" })
vim.keymap.set("n", "[b", ":bprev<cr>", { desc = "PREV BUFFER" })
