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

local function close_buffers(side)
	local all_bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()

	local current_buf_number = (side == "left" or side == "right")
		and (vim.api.nvim_buf_get_number(current_buf) or false)

	function write(buf, current_buf) end
	for _, buf in ipairs(all_bufs) do
		local buf_number = vim.api.nvim_buf_get_number(buf)

		local lro_condition = vim.bo[buf].filetype ~= "neo-tree"
			and vim.bo[buf].filetype ~= "toggleterm"
			and buf ~= current_buf
			and buf

		local buf_left = side == "left" and buf_number < current_buf_number and lro_condition
		local buf_right = side == "right" and buf_number > current_buf_number and lro_condition
		local buf_others = side == "others" and lro_condition

		local buf_all = side == "all" and buf

		local target_buf = buf_left or buf_right or buf_others or buf_all
		if target_buf then
			if vim.api.nvim_buf_get_option(target_buf, "modified") then
				vim.api.nvim_set_current_buf(target_buf)
				vim.api.nvim_command("silent noautocmd write")
				vim.api.nvim_set_current_buf(current_buf)
			end
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

vim.keymap.set("n", "<leader>bl", function()
	close_buffers("left")
end, { noremap = true, silent = true, desc = "CLOSE [B]UFFER [L]EFT" })

vim.keymap.set("n", "<leader>br", function()
	close_buffers("right")
end, { noremap = true, silent = true, desc = "CLOSE [B]UFFER [R]ight" })

vim.keymap.set("n", "<leader>bo", function()
	close_buffers("others")
end, { noremap = true, silent = true, desc = "CLOSE [B]UFFER [O]thers" })

vim.keymap.set("n", "<leader>q", function()
	close_buffers("all")
end, { noremap = true, silent = true, desc = "CLOSE [Q]uit" })
