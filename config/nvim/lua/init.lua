require('plugins')

require('lualine').setup({
  options = {
    theme = 'nord'
  }
})

require('null-ls').setup()

require('eslint').setup({
  bin = 'eslint',
  code_actions = {
    enable = true
  }
})

require('bufferline').setup{
  options = {
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    show_close_icon = true,
    always_show_bufferline = true
  }
}

require('gitsigns').setup()
