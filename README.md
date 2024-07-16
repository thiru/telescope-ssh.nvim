# Telescope SSH Picker

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension to open an SSH connection in Neovim's terminal emulator.

The list of hosts is parsed from **~/.ssh/config** and **~/.ssh/known_hosts**.


## Dependencies

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)


## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'thiru/telescope-ssh.nvim',
  depedencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    -- The following is necessary only if you'd like to change any of the defaults:
    require('ssh').setup({
      -- Whether to automically rename the buffer the connection is made on to the hostname
      auto_rename_buf = true
    })

    vim.keymap.set('n', '<leader>ss', '<CMD>Telescope ssh<CR>', {desc = 'Open an [S]SH connection'})
  end
}
```


## Usage

```lua
:Telescope ssh
```

Or,

```lua
:TelescopeSsh
```

This will start Neovims terminal emulator so the current buffer must be unmodified.
You can also use Telescope's alternative actions to open the SSH connection in a new:

- tab (`<C-t>`)
- horizontal split (`<C-x>`)
- vertical split (`<C-v>`)

The above bindings are Telescope defaults.
