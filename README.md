# Telescope SSH Picker

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension to open an SSH connection in Neovim's terminal emulator.

The list of hosts is parsed from **~/.ssh/config** and **~/.ssh/known_hosts**.

TODO: gif demo


## Dependencies

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)


## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'thiru/telescope-ssh.nvim',
  depedencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('telescope').load_extension('ssh')

    -- The following is necessary only if you'd like to change any of the defaults:
    require('ssh').setup({
      -- Whether to rename newly created tabs with the remote host name
      rename_tab = true
    })

    vim.keymap.set('n', '<leader>ss', '<CMD>Telescope ssh<CR>', {desc = 'Open an [S]SH connection in a new tab'})
  end
}
```


## Usage

```lua
:Telescope ssh
```

Or:

```lua
:TelescopeSsh
```
