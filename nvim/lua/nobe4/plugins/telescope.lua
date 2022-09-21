return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  requires = { "nvim-lua/plenary.nvim" },

  config = function()
    local telescope = require("telescope")
    local ts_builtin = require("telescope.builtin")

    -- Mapping
    local options = { noremap = true, silent = false }
    vim.keymap.set("n", "<Leader>f",  ts_builtin.find_files, options)
    vim.keymap.set("n", "<Leader>t",  ts_builtin.tags, options)
    vim.keymap.set("n", [[\]], ts_builtin.live_grep, options)

    -- Notational
    -- TODO: find a way to search for the filename as well
    vim.keymap.set("n", "<Leader>n", function()
      ts_builtin.live_grep({
        cwd = "~/Documents/docs",
        glob_pattern = { "*.md", "*.txt" },
      })
    end, options)
  end
}

