local awful = require('awful')
local wibox = require('wibox')
local music = require('ui.panels.top.music')
local weather = require('ui.panels.top.weather')

local kb_layout = awful.widget.keyboardlayout()
local clock = wibox.widget.textclock()
local systray = wibox.widget.systray()

local top_panel = {}
local super = 'Mod4'

top_panel.setup = function(s)
  local layout_selector = awful.widget.layoutbox({
    screen = s,
    buttons = {
      awful.button({}, awful.button.names.LEFT, function()
        awful.layout.inc(1)
      end),
      awful.button({}, awful.button.names.RIGHT, function()
        awful.layout.inc(-1)
      end),
    },
  })

  local taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = {
      awful.button({}, awful.button.names.LEFT, function(t)
        t:view_only()
      end),
      awful.button({ super }, awful.button.names.LEFT, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, awful.button.names.RIGHT, awful.tag.viewtoggle),
      awful.button({ super }, awful.button.names.RIGHT, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
    },
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

  awful.wibar({
    position = 'top',
    screen = s,
    widget = {
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
        layout_selector,
      },
    },
  })
end

return top_panel
