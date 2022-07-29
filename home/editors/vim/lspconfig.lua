vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")

local signs = { Error = "XX", Warn = "!!", Hint = "??", Info = "??" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require'lspconfig'.rnix.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.terraform_lsp.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.cssls.setup {}
require('lspconfig').yamlls.setup {
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            },
        },
        redhat = {
            telemetry = {
                disabled = false
            }
        },
    }
}
