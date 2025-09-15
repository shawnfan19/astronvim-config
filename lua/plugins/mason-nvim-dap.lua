local uv = vim.loop
-- local basePython = "/Users/sfan/miniforge3/bin/python"

-- local function get_python_from_pyrightconfig()
--   local cwd = vim.fn.getcwd()
--   local pyright_file = cwd .. '/pyrightconfig.json'
--
--   local fd = uv.fs_open(pyright_file, "r", 438)  -- 438 = 0666 octal
--   if not fd then return nil end
--
--   local stat = uv.fs_fstat(fd)
--   local data = uv.fs_read(fd, stat.size, 0)
--   uv.fs_close(fd)
--
--   if not data then return nil end
--
--   local ok, json = pcall(vim.json.decode, data)
--   if not ok or not json then return nil end
--
--   -- Try getting python from venvPath
--   if json.venvPath then
--     if vim.fn.executable(json.venvPath) == 1 then
--       return json.venvPath
--     end
--   end
--
--   -- Try constructing python path from venv name
--   if json.venv then
--     local guessed_path = vim.fn.expand("~") .. "/miniforge3/envs/" .. json.venv .. "/bin/python"
--     if vim.fn.executable(guessed_path) == 1 then
--       return guessed_path
--     end
--   end
--
--   return nil
-- end
--
return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      python = function(source_name)
        local dap = require("dap")
        dap.adapters.python = {
          type = "executable",
          command = "python",
          args = {
            "-m",
            "debugpy.adapter",
          },
        }

        dap.configurations.python = {
          {
            type = 'python',
            request = 'launch',
            name = "Launch file",
            program = "${file}",
            console = 'integratedTerminal',
          },
          {
            type = "python",
            request = "launch",
            name = "Launch file with arg",
            program = "${file}", -- This configuration will launch the current file if used.
            args = function()
              local args_string = vim.fn.input('arg: ')
              return vim.split(args_string, " +")
            end;
          },
        }
      end,
    },
  }
}
