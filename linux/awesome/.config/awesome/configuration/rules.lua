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

  -- App rules
  -- Discord
  ruled.client.append_rule({
    rule = { class = 'discord' },
    properties = { tag = screen[2].tags[1] },
  })
  -- Spotify
  ruled.client.append_rule({
    rule = { class = 'spotify' },
    properties = { tag = screen[2].tags[9] },
  })
  -- Lutris
  ruled.client.append_rule({
    rule = { class = 'Lutris' },
    properties = { tag = screen[2].tags[7] },
  })
  -- Steam - Main Window
  ruled.client.append_rule({
    rule_every = { class = 'steamwebhelper', name = 'Steam' },
    properties = { tag = screen[2].tags[7] },
  })
  -- Steam - Other Windows
  ruled.client.append_rule({
    rule = { class = 'steamwebhelper' },
    except = { name = 'Steam' },
    properties = { floating = true },
  })
  -- SSH Password
  ruled.client.append_rule({
    rule = { class = 'lxqt-openssh-askpass' },
    properties = { floating = true },
  })
  -- Bluetooth
  ruled.client.append_rule({
    rule = { class = 'blueberry.py' },
    callback = function(c)
      if not blueberry then
        blueberry = true
        c.minimized = true
      end
    end,
  })
end)
