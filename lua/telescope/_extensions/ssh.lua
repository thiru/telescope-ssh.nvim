local telescope = require('telescope')
local ssh = require('ssh')

return telescope.register_extension({
  setup = ssh.setup,
  exports = {ssh = ssh.picker},
})
