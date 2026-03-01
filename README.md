<h1 align="center">SnaxVim</h1>

<div align="center">

[![neovim](https://img.shields.io/badge/neovim-0.11-red.svg?style=flat-square&color=99e6ff&logo=Neovim&logoColor=white)](https://neovim.io/)
[![plugins](https://img.shields.io/badge/plugins-10-red.svg?style=flat-square&color=99ff99)](https://github.com/SnaxVim/SnaxVim/blob/main/lua/plugins/init.lua)
[![last commit](https://img.shields.io/github/last-commit/SnaxVim/SnaxVim?style=flat-square&color=ffe699)](https://github.com/SnaxVim/SnaxVim/pulse)
[![issues](https://img.shields.io/github/issues/SnaxVim/SnaxVim?style=flat-square&color=ff9999)](https://github.com/SnaxVim/SnaxVim/issues)

</div>

SnaxVim is a no-frills starter template for building your own Neovim configuration.

## Features

- **Minimal yet Capable**

  Only the essential plugins and configurations are included to support fundamental IDE-like features, including diagnostics, formatting, and debugging.  
  Language-specific features can be enabled by adding the appropriate configuration entries.

- **Exceptionally Fast Startuptime**

  Several built-in runtime plugins are disabled, and all plugins are lazy-loaded by default.  
  Note that plugins won't be loaded unless loading conditions are defined, such as events, keymaps, or user commands.

## Requirements

- **neovim** >= 0.11.0
- **git**
- [**tree-sitter-cli**](https://tree-sitter.github.io/tree-sitter/creating-parsers/1-getting-started.html#installation) for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- a C compiler for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- (optional) a [Nerd Font](https://www.nerdfonts.com/)

## Install

### Create a backup of your current Neovim files

<details open><summary>Linux and macOS</summary>

```sh
mv ~/.config/nvim ~/.config/nvim-bak
mv ~/.local/share/nvim ~/.local/share/nvim-bak
```

</details>

<details><summary>Windows</summary>

```bat
move %LOCALAPPDATA%\nvim %LOCALAPPDATA%\nvim-bak
move %LOCALAPPDATA%\nvim-data %LOCALAPPDATA%\nvim-bak-data
```

</details>

### [Fork](https://github.com/SnaxVim/SnaxVim/fork) and clone this repo

<details open><summary>Linux and macOS</summary>

```sh
git clone https://github.com/your-username/SnaxVim ~/.config/nvim
```

</details>

<details><summary>Windows</summary>

```bat
git clone https://github.com/your-username/SnaxVim %LOCALAPPDATA%/nvim
```

</details>

### Start Neovim

```
nvim
```

## File Structure

```
~/.config/nvim/
├─ lua/
│  ├─ autocmds/       -- auto commands
│  ├─ configs/        -- plugin-specific configuration files
│  ├─ keymaps/        -- key mappings
│  ├─ plugins/        -- plugin declarations
│  ├─ foldcolumn.lua  -- foldcolumn without digits
│  ├─ options.lua     -- global variables and editor options
│  └─ options_pre.lua -- settings evaluated before lazy.nvim
└─ init.lua           -- entry point
```

## Credits

- [NvChad/starter](https://github.com/NvChad/starter)
    - Startuptime improvements
- [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
    - Autocommands for nvim-lint
- [luukvbaal/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim)
    - Foldcolumn without digits
