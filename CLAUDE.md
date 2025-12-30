# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration repository that uses lazy.nvim as the plugin manager (single file setup). The configuration is written in Lua and focuses on Go development with support for multiple languages including Crystal, Terraform, Markdown, and Docker.

## Key Configuration Files

- `init.lua` - Main configuration file containing all plugin declarations, settings, and keybindings
- `README.md` - Installation instructions for setting up the configuration

## Plugin Management

This configuration uses **lazy.nvim** in single file setup mode (not Packer, vim-plug, or structured lazy.nvim setup).

### Installing/Updating Plugins

After modifying plugin declarations in `init.lua`:
1. Open Neovim (lazy.nvim will auto-install if missing)
2. Plugins install automatically on first launch
3. Use `:Lazy` to open the plugin manager UI
4. Use `:Lazy sync` to update plugins

Plugins are installed to: `~/.local/share/nvim/lazy/`

### lazy.nvim Bootstrap

The configuration includes automatic bootstrap code at the top of `init.lua` that:
- Clones lazy.nvim if it doesn't exist
- Adds it to the runtime path
- Handles installation errors gracefully

### Key Plugin Categories

**Core plugins:**
- `fzf` + `fzf.vim` - Fuzzy file finding (Ctrl-P for files, :GFiles in git repos)
- `nvim-tree.lua` - Modern file explorer with git integration (toggle with `<leader>n`)
- `lualine.nvim` - Fast, modern statusline and tabline (replaces vim-airline)
- `nvim-web-devicons` - File icons for lualine and nvim-tree (requires Nerd Font)
- `vim-fugitive` - Git integration
- `vim-gitgutter` - Git diff indicators in sign column
- `vim-buffergator` - Buffer management
- `nvim-terminal` - Terminal integration (toggle with `<leader>;`)
- `vim-commentary` - Comment toggling
- `vim-surround` - Surround text with quotes/brackets
- `ack.vim` - Search tool integration

**Language support:**
- `vim-go` - Primary Go development plugin with gopls integration
- `vim-terraform` - Terraform syntax and tools
- `vim-crystal` - Crystal language support
- `vim-markdown` - Enhanced markdown support
- `Dockerfile.vim` - Dockerfile syntax

**Colorschemes:**
- `gruvbox` (active)
- `dracula`

## Configuration Architecture

### Leader Key
The leader key is set to `,` (comma).

### Key Bindings Structure

**File Navigation:**
- `<C-p>` - Open fuzzy file finder (GFiles if in git repo, Files otherwise)
- `<leader>n` - Toggle nvim-tree file explorer
- `<leader><leader>` - Switch to last buffer
- `<leader>b` - Toggle buffer list (BuffergatorToggle)

**nvim-tree Navigation (when open):**
- `Enter` or `o` - Open file or directory
- `a` - Create new file/directory
- `d` - Delete file/directory
- `r` - Rename file/directory
- `x` - Cut file/directory
- `c` - Copy file/directory
- `p` - Paste file/directory
- `R` - Refresh tree
- `H` - Toggle hidden files
- `q` - Close nvim-tree

**Window Navigation:**
- `<C-h/j/k/l>` - Navigate between splits

**Terminal:**
- `<leader>;` - Toggle terminal window

**Go-specific (in Go files):**
- `<leader>gd` - List all declarations in package (`:GoDeclsDir`)
- `<leader>ga` - Go to alternate file (test ↔ implementation)
- `<leader>gah` - Go to alternate file in horizontal split
- `<leader>gav` - Go to alternate file in vertical split

**Search:**
- `\` - Clear search highlighting

**Custom Commands:**
- `:Vimrc` - Open init.lua in vertical split
- `:Reload` - Reload configuration from init.lua

### Editor Behavior

- **Indentation:** 2 spaces by default (expandtab enabled)
- **Line numbers:** Enabled with current line highlighting
- **Color columns:** 81 and 121 character markers
- **Auto-trim:** Trailing whitespace is automatically removed on save
- **Search:** Case-insensitive unless uppercase letters are used

### vim-go Configuration

vim-go is configured with these settings:
- `goimports` as the format command (runs on save)
- gopls LSP integration enabled
- Snippet engine set to 'automatic'
- Tag transformation uses snakecase
- Auto type info enabled
- Metalinter disabled on autosave

## Working with Go Code

When editing Go files:
1. Code is automatically formatted with `goimports` on save
2. Type information appears automatically
3. Use `:GoDecls` or `<leader>gd` to navigate declarations
4. Use `<leader>ga` to jump between implementation and test files
5. gopls provides LSP features (go-to-definition, hover, etc.)

## Modifying Configuration

When adding new plugins:
1. Add the plugin to the `require("lazy").setup({ ... })` table in `init.lua`
2. Plugin format: `'author/plugin-name'` or `{ 'author/plugin-name', config = function() ... end }`
3. Save the file - lazy.nvim will detect changes automatically
4. Run `:Lazy sync` or restart Neovim

When changing settings or keybindings:
1. Edit `init.lua` directly (settings are below the lazy.nvim setup block)
2. Run `:Reload` to apply changes without restarting
