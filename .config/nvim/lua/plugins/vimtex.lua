return {
	{
		"lervag/vimtex",
		lazy = true,
		init = function()
			vim.g.vimtex_view_method = "zathura" 
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_conceal = "abdmg"
      vim.cmd("filetype plugin on")
    end,
		config = function()
      vim.opt.conceallevel = 1
    end,
	},
}

