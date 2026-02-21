return {
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap = require("dap")
			local widgets = require('dap.ui.widgets')
			require("nobe4.mappings").dap(dap, widgets)

			dap.adapters.delve = function(callback, config)
				if config.mode == 'remote' and config.request == 'attach' then
					callback({
						type = 'server',
						host = config.host or '127.0.0.1',
						port = config.port or '38697'
					})
				else
					callback({
						type = 'server',
						port = '${port}',
						executable = {
							command = 'dlv',
							args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
						}
					})
				end
			end


			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}"
				},
				{
					type = "delve",
					name = "Debug test",
					request = "launch",
					mode = "test",
					program = "${file}"
				},
				{
					type = "delve",
					name = "Debug test (all)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}"
				}
			}
		end
	}
}
