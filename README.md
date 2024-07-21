# Telescope SSH Picker

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension to open an SSH
connection using Neovim's terminal emulator.

The list of hosts is parsed from **~/.ssh/config** and **~/.ssh/known_hosts**.


## Dependencies

Required:

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

Optional:

- [taboo.vim](https://github.com/gcmt/taboo.vim)

## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'thiru/telescope-ssh.nvim',
  depedencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('ssh').setup({})
  end,
  keys = {
    {'<leader>ss', '<CMD>Telescope ssh<CR>', desc = 'Open an [S]SH connection'},
  },
}
```

## Config

Example config with default settings:

```lua
config = function()
  require('ssh').setup({
    -- Whether to automatically reconnect SSH connections disconnected with a non-zero exit code.
    auto_reconnect = true,
    -- Whether to automically rename the buffer the connection is made on to the hostname
    auto_rename_buf = true,
  })
end
```

If you are making use of tabs and have [taboo.vim](https://github.com/gcmt/taboo.vim), it will be
used to set the tab name to the SSH host. I personally use the following taboo.vim config:

```lua
config = function()
  vim.g.taboo_tab_format = ' %I %f '
  vim.g.taboo_renamed_tab_format = ' %I %l '
end
```

## Usage

```lua
:Telescope ssh
```

Or,

```lua
:TelescopeSsh
```

This will launch the SSH picker using Telescope.

All actions will start an instance of Neovim's terminal emulator. The default action (`<CR>`)
will use the current buffer, so it must be unmodified otherwise an error will occur.

You can also use Telescope's alternative actions to open the SSH connection in a new:

- tab (`<C-t>`)
- horizontal split (`<C-x>`)
- vertical split (`<C-v>`)

Note, the above bindings are Telescope defaults. You can change these in your Telescope config.
