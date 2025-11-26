vim.g.mapleader = ","

local set = vim.keymap.set

set("i", "jj", "<ESC>")
-- NOTE: check packadd nohlsearch
set("n", "<leader>nh", ":nohl<CR>")
set("n", "<leader>to", ":tabnew<CR>")
set("n", "<leader>tq", ":tabclose<CR>")
-- NOTE: default gt and gT
set("n", "<leader>tl", ":tabn<CR>")
set("n", "<leader>th", ":tabp<CR>")
set("n", "<leader>rn", ":set relativenumber!<CR>")


set("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay_hints" }
)

vim.api.nvim_create_user_command("W", function()
  vim.cmd("terminal sl")
  vim.cmd([[autocmd TermClose * ++once lua vim.cmd("bdelete!")]])
end, { nargs = 0 })

-- FIX: maybe move this to telescope.lua
-- UPD: just nuke this
set("n", "<S-h>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<CR>")
