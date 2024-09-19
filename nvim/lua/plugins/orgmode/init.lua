return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/Vaults/Personal',
        org_default_notes_file = '~/Vaults/Personal/inbox.md',
      })
    end,
  }
}
