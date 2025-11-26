return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
    require("catppuccin").setup {
      custom_highlights = function(mocha) 
        return {
          FloatBorder = { fg = mocha.mauve},
        }
      end
      }
		vim.cmd.colorscheme "catppuccin"
    end,
  }

