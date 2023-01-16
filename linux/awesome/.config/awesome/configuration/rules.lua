local awful = require('awful')
local ruled = require('ruled')

ruled.client.connect_signal('request::rules', function()
  -- Global Rules
  ruled.client.append_rule({
    id = 'global',
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Tag & Screen Rules
  ruled.client.append_rules({
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
  })
end)
