local dap = require("dap")
local dapui = require("dapui")
local dapgo = require("dap-go")

dapui.setup()
dapgo.setup()

vim.api.nvim_create_user_command("DapUIToggle", function()
	dapui.toggle()
end, { bang = true })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end