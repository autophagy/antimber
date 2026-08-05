vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")

local signs = { Error = "XX", Warn = "!!", Hint = "??", Info = "??" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.config("yamlls", {
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
})

vim.lsp.enable({
    "bashls",
    "terraform_lsp",
    "rust_analyzer",
    "yamlls",
    "gopls",
    "elmls",
    "purescriptls",
})
