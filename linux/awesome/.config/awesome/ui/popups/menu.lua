local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local settings = require('settings')

local instance = nil

local function new()
  local menu = awful.menu({
    items = {
      { 'Terminal', settings.terminal },
      {
        'Hotkeys',
        function()
          hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
      },
      { 'Manual', settings.terminal .. ' -e man awesome' },
      {
        'Edit Config',
        settings.terminal
          .. ' -e '
          .. settings.editor
          .. ' '
          .. awesome.conffile,
      },
      { 'Restart', awesome.restart },
      {
        'Quit',
        function()
          awesome.quit()
        end,
      },
    },
  })

  return menu
end

if not instance then
  instance = new()
end

return instance
