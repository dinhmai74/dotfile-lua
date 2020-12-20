local function nmap(command, value)
    vim.fn.nvim_set_keymap('n',command,value,{noremap = true, silent = true})
end

local function imap(command, value)
    vim.fn.nvim_set_keymap('i',command,value,{noremap = true, silent = true})
end

local function vmap(command, value)
    vim.fn.nvim_set_keymap('v',command,value,{noremap = true, silent = true})
end

local function tmap(command, value)
    vim.fn.nvim_set_keymap('t',command,value,{noremap = true, silent = true})
end

nmap('<leader>un', ':UndotreeToggle<Cr>')
nmap('<leader>lc', ':<up>')
nmap('Q', ':q!<CR>')
imap('<C-b>', '<C-x><C-f>')
nmap('zP', '"+P')
vmap('<leader>p', '"_dP')
tmap(',,', [[<C-\><C-n>]])

return {
    nmap = nmap,
    imap = imap,
    vmap = vmap,
    tmap = tmap,
}
