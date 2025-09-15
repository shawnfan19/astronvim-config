return {
  "rcarriga/nvim-dap-ui",
  config = function(plugin, opts)
    -- run default AstroNvim nvim-dap-ui configuration function
    require("astronvim.plugins.configs.nvim-dap-ui")(plugin, opts)

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized.dapui_config = nil
    dap.listeners.before.event_terminated.dapui_config = nil
    dap.listeners.before.event_exited.dapui_config = nil

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

  end,
}
