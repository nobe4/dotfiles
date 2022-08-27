local command = vim.api.nvim_create_user_command
local opts = { bang = true };

-- Source and edit vimrc file
command("SourceVimrc", "silent source $MYVIMRC", opts)
command("VimrcSource", "silent source $MYVIMRC", opts)
command("EditVimrc", "edit $MYVIMRC", opts)
command("VimrcEdit", "edit $MYVIMRC", opts)

local sudo_write_cmd = "write !sudo tee % >/dev/null"
command("SudoWrite", sudo_write_cmd, opts)
command("WriteSudo", sudo_write_cmd, opts)

command("JSONPretty", "%!jq '.'", opts)
command("Writing", "setlocal wrap linebreak spell spellcapcheck= filetype=markdown", opts)

command("Writing", "setlocal wrap linebreak spell spellcapcheck= filetype=markdown", opts)
