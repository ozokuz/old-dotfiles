local awful = require('awful')
local beautiful = require('beautiful')
local keys = require('configuration.keys')

awful.rules.rules = {
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.keyboard.client,
      buttons = keys.mouse.client,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },
  {
    rule = { class = 'discord' },
    properties = { screen = 2, tag = '1' },
  },
  {
    rule = { class = 'Spotify' },
    properties = { screen = 2, tag = '9' },
  },
  {
    rule = { class = 'Lutris' },
    properties = { screen = 2, tag = '7' },
  },
  {
    rule_every = { class = 'Steam', name = 'Steam' },
    properties = { screen = 2, tag = '7' },
  },
  {
    rule = { class = 'Steam' },
    except = { name = 'Steam' },
    properties = { floating = true },
  },
  {
    rule = { class = 'blueberry.py' },
    properties = { minimized = true },
  },
}
