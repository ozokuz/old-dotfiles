local awful = require('awful')
require('awful.autofocus')

require('configuration.theme')
require('configuration.keys')
require('configuration.layouts')
require('configuration.wallpaper')
require('ui.notifications')
require('ui.popups.volume')

local top_panel = require('ui.panels.top')

awful.spawn.with_shell('~/.config/awesome/autorun.sh')

screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag(
    { '1', '2', '3', '4', '5', '6', '7', '8', '9' },
    s,
    awful.layout.layouts[1]
  )

  top_panel.setup(s)
end)

require('configuration.rules')

client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)
