local lspconfig = require'lspconfig'

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")

local signs = { Error = "XX", Warn = "!!", Hint = "??", Info = "??" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


lspconfig.rnix.setup{}
lspconfig.bashls.setup{}
lspconfig.terraform_lsp.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.cssls.setup {
    cmd = { "css-languageserver", "--stdio" },
    capabilities = capabilities
}
lspconfig.yamlls.setup {
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
lspconfig.dhall_lsp_server.setup{}
lspconfig.gopls.setup{}
lspconfig.elmls.setup{}
