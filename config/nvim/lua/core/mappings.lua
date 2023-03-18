local utils = require("core.utils")
local mapper = utils.mapper_factory
local nnoremap = mapper("n")
local tnoremap = mapper("t")
local vnoremap = mapper("v")
local xnoremap = mapper("x")
local no_silent = { silent = false }

-- No need to keep holding shift
nnoremap(";", ":", no_silent)
vnoremap(";", ":", no_silent)

-- Map H and L to start and end of the line respectively (makes more sence that way)
nnoremap("H", "0")
nnoremap("L", "$")

-- Navigating between windows
nnoremap("<C-Up>", function()
  utils.navigate_pane_or_window("k")
end)
nnoremap("<C-Down>", function()
  utils.navigate_pane_or_window("j")
end)
nnoremap("<C-Left>", function()
  utils.navigate_pane_or_window("h")
end)
nnoremap("<C-Right>", function()
  utils.navigate_pane_or_window("l")
end)

-- Moving windows
nnoremap("<C-S-Up>", ":wincmd K<CR>")
nnoremap("<C-S-Down>", ":wincmd J<CR>")
nnoremap("<C-S-Left>", ":wincmd H<CR>")
nnoremap("<C-S-Right>", ":wincmd L<CR>")

-- Resizing windows
nnoremap("<M-Up>", ":resize +2<CR>")
nnoremap("<M-Down>", ":resize -2<CR>")
nnoremap("<M-Left>", ":vertical resize +2<CR>")
nnoremap("<M-Right>", ":vertical resize -2<CR>")

-- Quick moving around while keeping the cursor fixed in middle
nnoremap("J", "5jzz")
nnoremap("K", "5kzz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Buffer management
nnoremap("<C-L>", ":bnext<CR>")
nnoremap("<C-H>", ":bprevious<CR>")
nnoremap("<Leader>qw", ":bdelete<CR>")

-- Don't put text in register on delete char
mapper({ "n", "v" })("x", '"_x')

-- Keep visual mode indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Quick edit/source config files
nnoremap("<Leader>ev", ":edit $MYVIMRC<CR>", {
  desc = "Edit $MYVIMRC",
})
-- TODO: Make it hard reload init.lua
nnoremap("<Leader>sv", ":source $MYVIMRC<CR>", {
  desc = "Source $MYVIMRC",
})
nnoremap("<Leader>ed", ":edit $DOTS_DIR/config<CR>", {
  desc = "Edit dotfiles",
})
nnoremap("<Leader>se", utils.save_and_exec, {
  desc = "Save and execute vim/lua files",
})

-- Make <Esc> to actually escape from terminal mode
tnoremap("<Esc>", "<C-\\><C-n>")

-- Toggle highlights
nnoremap("<Leader>sh", ":set hlsearch!<CR>", {
  desc = "Toggle search highlighting",
})
nnoremap("<Leader>th", function()
  if vim.g.tab_highlight == true then
    vim.cmd("highlight clear Tabs")
    vim.notify("Disabled whitespace highlighting!")
  else
    vim.cmd("highlight Tabs guibg=yellow")
    vim.notify("Enabled whitespace highlighting!")
  end
  vim.g.tab_highlight = not vim.g.tab_highlight
end, {
  desc = "Toggle tab highlighting",
})

--- Few mappings I stole from @akinsho :)
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/

-- Quick find and replace
vnoremap(
  "<Leader>rr",
  [[<esc>:'<,'>s//<left>]],
  { desc = "Within visually selected area", silent = false }
)
nnoremap(
  "<Leader>rr",
  [[:%s//<left>]],
  { desc = "Replace text", silent = false }
)
vnoremap(
  "<Leader>rw",
  [["zy:%s/<C-r><C-o>"/]],
  { desc = "Visually selected text", silent = false }
)
nnoremap(
  "<Leader>rw",
  [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
  { desc = "Replace word under cursor", silent = true }
)

-- Search visual selection
vnoremap("//", [[y/<C-R>"<CR>]])

-- Multiple Cursor Replacement
---@see http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-- 1. Position the cursor over a word; alternatively, make a selection.
-- 2. Hit cq to start recording the macro.
-- 3. Once you are done with the macro, go back to normal mode.
-- 4. Hit Enter to repeat the macro over search matches.
function Setup_CR()
  nnoremap(
    "<Enter>",
    [[:nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z]],
    { buffer = true }
  )
end
vim.g.mc = [[y/\V<C-r>=escape(@", '/')<CR><CR>]]

nnoremap("cn", "*``cgn")
nnoremap("cN", "*``cgN")

vnoremap("cn", [[g:mc . "``cgn"]], { expr = true })
vnoremap("cN", [[g:mc . "``cgN"]], { expr = true })

nnoremap("cq", [[:\<C-u>call v:lua.Setup_CR()<CR>*``qz]])
nnoremap("cQ", [[:\<C-u>call v:lua.Setup_CR()<CR>#``qz]])

vnoremap(
  "cq",
  [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . g:mc . "``qz"]],
  { expr = true }
)
vnoremap(
  "cQ",
  [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . substitute(g:mc, '/', '?', 'g') . "``qz"]],
  { expr = true }
)

-- Replicate netrw functionality (gx/gf)
nnoremap("gx", utils.open_link)

-- few greatest remaps ever (courtesy of @theprimeagen)
xnoremap("<Leader>p", [["_dP]])
mapper({ "x", "n" })("<Leader>y", [["+y]])
