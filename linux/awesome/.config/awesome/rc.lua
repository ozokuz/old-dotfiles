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

local icons = {
  {
    '\u{f059f}', -- Web
    '\u{f02e}', -- Bookmark
    '\u{f0219}', -- Document
    '\u{f0169}', -- Code
    '\u{e7c5}', -- Vim
    '\u{f01e7}', -- Globe
    '\u{f01c5}', -- Desktop
    '\u{f427}', -- Rocket
    '\u{f02b4}', -- Controller
  },
  {
    '\u{f066f}', -- Discord
    '\u{f26b}', -- Internet Explorer :D
    '\u{f489}', -- Terminal
    '\u{f121}', -- Code
    '\u{e615}', -- Config
    '\u{f015f}', -- Cloud
    '\u{f1b6}', -- Steam
    '\u{f232}', -- WhatsApp
    '\u{f1bc}', -- Spotify
  },
}

screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag(icons[s.index], s, awful.layout.layouts[1])

  top_panel.setup(s)
end)

require('configuration.rules')

client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

local function bar_woop(c)
  local s = c.screen
  local w = s.wibar
  local m = w.margins
  local margin = c.maximized and 0 or 16
  local width = c.maximized and s.geometry.width or s.geometry.width - 32
  m.top = margin
  m.left = margin
  m.right = margin
  w.width = width
end

client.connect_signal('property::maximized', function(c)
  bar_woop(c)
end)
