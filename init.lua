-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Core
  'mileszs/ack.vim',
  'jeetsukumaran/vim-buffergator',
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'airblade/vim-gitgutter',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          icons_enabled = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        tabline = {
          lualine_a = {'buffers'},
          lualine_z = {'tabs'}
        },
      })
    end,
  },
  'tpope/vim-fugitive',
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Disable netrw (vim's built-in file explorer) as recommended by nvim-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('nvim-tree').setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
    end,
  },
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-abolish',
  {
    's1n7ax/nvim-terminal',
    config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup({
        window = {
          -- Do `:h :botright` for more information
          -- NOTE: width or height may not be applied in some "pos"
          position = 'botright',

          -- Do `:h split` for more information
          split = 'sp',

          -- Width of the terminal
          width = 50,

          -- Height of the terminal
          height = 15,
        },

        -- keymap to toggle open and close terminal window
        toggle_keymap = '<leader>;',
      })
    end,
  },
  'A7Lavinraj/fyler.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',

  -- Languages
  'hashivim/vim-terraform',
  'smerrill/vcl-vim-plugin',
  'cespare/vim-toml',
  'vim-crystal/vim-crystal',
  'tpope/vim-markdown',
  'ekalinin/Dockerfile.vim',
  'fatih/vim-go',

  -- Colorschemes
  'dracula/vim',
  'gruvbox-community/gruvbox',
})

vim.cmd('filetype plugin indent on') -- required

vim.cmd('let mapleader = ","')

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Default indent settings
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Line numbers
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '81,121'

-- Cross-line delete using backspace
vim.opt.backspace = 'indent,eol,start'

-- Neovim only: incremental substitute
vim.opt.inccommand = 'nosplit'

-- Add Vimrc command that opens .vimrc
vim.cmd('command! Vimrc :vs $MYVIMRC')

-- Add reload command that reloads $MYVIMRC
vim.cmd('command! Reload :source $MYVIMRC')

-- vim-markdown
vim.g.markdown_fenced_languages = {'go', 'ruby', 'bash=sh'}

-- lualine (configured in plugin setup above)
vim.opt.laststatus = 2

-- vim-buffergator
vim.g.buffergator_autoupdate = 1
vim.g.buffergator_viewport_split_policy = 'T'

-- Switch between last two buffers
vim.api.nvim_set_keymap('n', '<leader><leader>', '<c-^>', {})

-- BuffergatorToggle
vim.api.nvim_set_keymap('n', '<leader>b', ':BuffergatorToggle<CR>', { noremap = true, silent = true })

-- nvim-tree toggle
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.api.nvim_set_keymap('n', '\\', ':noh<return>', {})

-- Trim trailing whitespace
vim.cmd('autocmd BufWritePre * :%s/\\s\\+$//e')

-- Abbreviations
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
]])

-- Window navigation
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', {})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', {})
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {})

-- Colorscheme
vim.cmd('colorscheme gruvbox')

-- fzf config
vim.opt.runtimepath:append('/usr/local/opt/fzf')
vim.g.fzf_action = { ['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit' }

if vim.fn.isdirectory('.git') == 1 then
  vim.api.nvim_set_keymap('n', '<C-p>', ':GFiles --cached --others<cr>', {})
else
  vim.api.nvim_set_keymap('n', '<C-p>', ':Files<cr>', {})
end

-- vim-go config
vim.g.go_fmt_command = 'goimports'
vim.g.go_metalinter_autosave = 0
vim.g.go_metalinter_deadline = '2s'
vim.g.go_auto_type_info = 1
vim.g.go_version_warning = 0
vim.g.go_snippet_engine = 'automatic'
vim.g.go_gopls_enabled = 1
vim.g.go_addtags_transform = 'snakecase'

-- List all declarations in package
vim.cmd([[au FileType go nmap <leader>gd :GoDeclsDir<cr>]])

-- Go to alternate file
vim.cmd([[au FileType go nmap <leader>ga <Plug>(go-alternate-edit)]])
vim.cmd([[au FileType go nmap <leader>gah <Plug>(go-alternate-split)]])
vim.cmd([[au FileType go nmap <leader>gav <Plug>(go-alternate-vertical)]])

