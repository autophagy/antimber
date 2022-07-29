vim.opt.spelllang = { 'en_gb', 'en_us', 'de_de' }

vim.cmd [[
  augroup spellCheckingEnabled
  au!
  au FileType markdown,rst,text,mail,tex setlocal spell
  augroup end
]]
