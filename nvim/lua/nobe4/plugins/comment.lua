return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      toggler = {
        line = "<leader>cc",
        block = "<leader>bc",
      },
      opleader = {
        line = "<Leader>c",
        block = "<Leader>b",
      }
    })
  end
}

