local awful = require('awful')
local ruled = require('ruled')

local blueberry = false

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
      properties = { screen = 2, tag = screen[2].tags[1] },
    },
    {
      rule = { class = 'spotify' },
      properties = { screen = 2, tag = screen[2].tags[9] },
    },
    {
      rule = { class = 'Lutris' },
      properties = { screen = 2, tag = screen[2].tags[7] },
    },
    {
      rule_every = { class = 'Steam', name = 'Steam' },
      properties = { screen = 2, tag = screen[2].tags[7] },
    },
    {
      rule = { class = 'Steam' },
      except = { name = 'Steam' },
      properties = { floating = true },
    },
    {
      rule = { class = 'lxqt-openssh-askpass' },
      properties = { floating = true },
    },
    {
      rule = { instance = 'Blueberry.py' },
      callback = function(c)
        if not blueberry then
          blueberry = true
          c.minimized = true
        end
      end,
    },
  })
end)
