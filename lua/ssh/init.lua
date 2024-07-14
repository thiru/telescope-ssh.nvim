local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local u = require('ssh.utils')

local M = {
  opts = {
    rename_tab = true,
  }
}

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend('force', M.opts, opts)

  vim.api.nvim_create_user_command(
    'TelescopeSsh',
    M.picker,
    {bang = true,
     desc = 'Open Telescope SSH picker'})
end

M.parse_ssh_config = function()
  local source_file = vim.uv.os_homedir() .. '/.ssh/config'

  if not vim.uv.fs_stat(source_file) then
    return {}
  end

  local hosts = {}

  for _, line in pairs(vim.fn.readfile(source_file)) do
    local match = string.match(line, "^%s*Host%s+(.+)%s*$")
    if match and match ~= '*' then
      table.insert(hosts, match)
    end
  end

  table.sort(hosts)
  return hosts
end

M.parse_known_hosts = function()
  local source_file = vim.uv.os_homedir() .. '/.ssh/known_hosts'

  if not vim.uv.fs_stat(source_file) then
    return {}
  end

  local hosts = {}

  for _, line in pairs(vim.fn.readfile(source_file)) do
    local match = string.match(line, "^%s*([%w.]+)[%s\\,]")
    if match and not vim.tbl_contains(hosts, match) then
      table.insert(hosts, match)
    end
  end

  table.sort(hosts, u.sort_alpha_before_number)
  return hosts
end

M.parse_hosts = function()
  local hosts = M.parse_ssh_config()

  for _, v in pairs(M.parse_known_hosts()) do
    if not vim.tbl_contains(hosts, v) then
      table.insert(hosts, v)
    end
  end

  return hosts
end

M.rename_tab = function(name)
  -- Adding spaces around name to avoid collision with a path which may exist locally
  local safe_name = ' ' .. name .. ' '

  -- Intentionally suppressing rename error. This usually happens when a buffer with the same name
  -- exists. So, if it fails we just keep the default name, which seems good enough.
  pcall(function() vim.api.nvim_buf_set_name(0, safe_name) end)
end

M.picker = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = 'SSH Picker',
    finder = finders.new_table({
      results = M.parse_hosts()
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local host = ''
        if selection == nil then
          host = action_state.get_current_line()
        else
          host = selection[1]
        end
        vim.cmd.tabnew()
        vim.fn.termopen('ssh ' .. host)
        if (M.opts.rename_tab) then
          M.rename_tab(host)
        end
        vim.schedule(function()
          vim.cmd.startinsert()
        end)
      end)
      return true
    end,
  }):find()
end

return M
