local configure_codelldb = function()
  local dap = require 'dap'
  dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
  }

  dap.configurations.rust = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executale: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      --'rcarriga/nvim-dap-ui',
    },
    config = function()
      local dap = require 'dap'

      -- Configuration for debugging ui.
      --[[ Opens and closes all the debug windows, when the debugger starts.
      local dapui = require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      --]]

      -- configure debug adapters
      configure_codelldb()

      vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, { desc = '[t]oggle breakpoint' })
      vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[c]ontinue (start debugger)' })
      vim.keymap.set('n', '<Leader>dq', dap.disconnect, { desc = '[q]uit' })
      vim.keymap.set('n', '<Leader>ds', dap.step_into, { desc = 'step into' })
      vim.keymap.set('n', '<Leader>do', dap.step_out, { desc = 'step out' })
      vim.keymap.set('n', '<Leader>dh', dap.step_back, { desc = 'step back' })
      vim.keymap.set('n', '<Leader>dn', dap.step_over, { desc = 'step over' })
      vim.keymap.set('n', '<Leader>dr', dap.repl.toggle, { desc = '[t]oggle repl' })
      vim.keymap.set('n', '<Leader>dd', dap.clear_breakpoints, { desc = '[d]elete all breakpoints' })
      --vim.keymap.set('n', '<Leader>dl', dap.set_log_level, { desc = 'show [l]og/output' })
    end,
  },
}
