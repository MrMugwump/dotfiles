vim.api.nvim_create_user_command(
    "ConfigTree",
    "Neotree dir=" .. vim.fn.stdpath("config"),
    {}
)

-- ignore_files = {
-- 	".swp",
-- 	".aux",
-- 	".fls",
-- 	".fdb_latexmk",
-- 	".fls",
-- 	".synctex.gz",
-- },
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
				hide_by_pattern = {
				  "*/LaTeX/*.aux",
				  "*.bbl",
				  "*.blg",
				  "*.fls",
				  "*.fdb_latexmk",
				  "*.synctex.gz",
				  "*.log",
				  "*.out",
				}
			}
		}
	}
  }
}


