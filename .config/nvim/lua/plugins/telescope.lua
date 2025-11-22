return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require("telescope")
    local set = vim.keymap.set
    local act = require("telescope.actions")
    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = act.move_selection_previous,
            ["<C-j>"] = act.move_selection_next,
          },
          n = {
            ["q"] = act.close,
            ["d"] = act.delete_buffer,
          },
        },
      },
    })
  end,
  keys = {
    {'<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files'},
    {'<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live grep'},
    {'<leader>fb', "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<CR>",
    desc = 'Telescope buffers'},
    {'<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags'},
  }
}
