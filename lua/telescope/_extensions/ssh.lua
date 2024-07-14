local telescope = require('telescope')
local ssh = require('ssh')

return telescope.register_extension({
  exports = {ssh = ssh.picker},
})
