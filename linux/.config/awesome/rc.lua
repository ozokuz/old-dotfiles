local awful = require('awful')
local beautiful = require('beautiful')
require('awful.autofocus')

require('configuration.theme')
local wallpaper = require('configuration.wallpaper')
local keys = require('configuration.keys')
local top_panel = require('ui.panels.top')

awful.layout.layouts = {
  awful.layout.suit.spiral,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}

awful.spawn.with_shell('~/.config/awesome/autorun.sh')

screen.connect_signal('property::geometry', wallpaper.set)

awful.screen.connect_for_each_screen(function(s)
  wallpaper.set(s)

  awful.tag(
    { '1', '2', '3', '4', '5', '6', '7', '8', '9' },
    s,
    awful.layout.layouts[1]
  )

  top_panel.setup(s)
end)

root.keys(keys.keyboard.global)

root.buttons(keys.mouse.global)

require('configuration.rules')

client.connect_signal('manage', function(c)
  if
    awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_normal
end)
