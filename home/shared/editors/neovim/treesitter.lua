require("nvim-treesitter").setup {}

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
