-- Neovim entry point. Plugins managed by lazy.nvim; settings live in settings.vim.

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Source vimscript settings BEFORE plugins load, so g: vars (copilot, easymotion,
-- syntastic, netrw-disable for defx, ...) are in effect when plugins initialize.
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/settings.vim')

require('lazy').setup({
  -- Editing / motions
  'easymotion/vim-easymotion',
  'tpope/vim-abolish',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'jiangmiao/auto-pairs',
  'alvan/vim-closetag',

  -- Git
  'tpope/vim-fugitive',

  -- Folding / indenting
  'tmhedberg/SimpylFold',
  'rayburgemeestre/phpfolding.vim',
  'captbaritone/better-indent-support-for-php-with-html',

  -- PHP
  'StanAngeloff/php.vim',
  'sumpygump/php-documentor-vim',
  'alvan/vim-php-manual',
  'vim-vdebug/vdebug',

  -- Languages / syntax
  'ElmCast/elm-vim',
  'elixir-editors/vim-elixir',
  'jparise/vim-graphql',
  'neo4j-contrib/cypher-vim-syntax',
  'chrisbra/csv.vim',

  -- Tooling
  'vim-syntastic/syntastic',
  'craigemery/vim-autotag',
  'will133/vim-dirdiff',
  'gcmt/taboo.vim',
  'github/copilot.vim',

  -- File explorer (Python remote plugin; needs pynvim + :UpdateRemotePlugins)
  { 'Shougo/defx.nvim', build = ':UpdateRemotePlugins' },

  -- Treesitter (parsers required by render-markdown)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',  -- master is archived and breaks on Neovim 0.12; main supports it
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({ 'markdown', 'markdown_inline' })
      -- main branch does not auto-enable highlighting; start it per filetype.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown' },
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('render-markdown').setup({})
      -- The plugin's default highlights link to ColorColumn / Diff* groups, which
      -- are loud (red/green) in colorscheme 'vim'. Keep markdown minimal and
      -- transparency-friendly by clearing code and heading backgrounds.
      -- Registered after setup() (so it runs after the plugin's own ColorScheme
      -- handler) and re-applied on ColorScheme so it survives reloads.
      local function tame()
        vim.api.nvim_set_hl(0, 'RenderMarkdownCode', {})
        for i = 1, 6 do
          vim.api.nvim_set_hl(0, 'RenderMarkdownH' .. i .. 'Bg', {})
        end
      end
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('RenderMarkdownTame', { clear = true }),
        callback = tame,
      })
      tame()
    end,
  },
}, {
  defaults = { lazy = false },
  install = { missing = true },
  change_detection = { notify = false },
})
