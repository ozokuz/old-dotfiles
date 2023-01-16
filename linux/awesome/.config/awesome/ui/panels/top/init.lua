local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local keys = require('configuration.keys')
local music = require('ui.panels.top.music')
local weather = require('ui.panels.top.weather')

local kb_layout = awful.widget.keyboardlayout()
local clock = wibox.widget.textclock()
local systray = wibox.widget.systray()

local top_panel = {}

top_panel.setup = function(s)
  local statusbar = awful.wibar({ position = 'top', screen = s })

  local layoutselector = awful.widget.layoutbox(s)
  layoutselector:buttons(
    gears.table.join(
      awful.button({}, awful.button.names.LEFT, function()
        awful.layout.inc(1)
      end),
      awful.button({}, awful.button.names.RIGHT, function()
        awful.layout.inc(-1)
      end)
    )
  )

  local taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = keys.mouse.taglist,
  })

  local tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    widget_template = {
      {
        {
          {
            id = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left = 10,
        right = 10,
        widget = wibox.container.margin,
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
  })

  statusbar:setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      taglist,
    },
    tasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      music,
      weather,
      kb_layout,
      systray,
      clock,
      layoutselector,
    },
  })
end

return top_panel
