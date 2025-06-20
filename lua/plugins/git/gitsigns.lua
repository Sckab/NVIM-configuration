return {
  "lewis6991/gitsigns.nvim",
  lazy = true, -- ⚡ PERFORMANCE: Load when needed
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
  config = function()
    vim.o.termguicolors = true

    require('gitsigns').setup {
      signs = {
        add          = {hl = 'GitSignsAdd', text = '│', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '|', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '|', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '|', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      numhl = false,
      linehl = false,
      watch_gitdir = { interval = 1000 },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 300,
      },
    }
  end
}
