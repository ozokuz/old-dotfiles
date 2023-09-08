local awful = require('awful')
local wibox = require('wibox')
local music = require('ui.panels.top.music')
local weather = require('ui.panels.top.weather')
local gears = require('gears')

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
    filter = awful.widget.taglist.filter.all,
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
    style = {
      font = 'FiraCode Nerd Font 14',
      -- shape = gears.shape.rounded_rect,
    },
    widget_template = {
      {
        {
          {
            id = 'text_role',
            forced_width = 20,
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.align.horizontal,
        },
        margins = 2,
        widget = wibox.container.margin,
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
  })

  local tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    --[[ filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate({ context = 'tasklist', action = 'toggle_minimization' })
      end),
      awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(1)
      end),
    }, ]]
    --[[ widget_template = {
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
    }, ]]
  })

  s.wibar = awful.wibar({
    position = 'top',
    screen = s,
    margins = {
      top = 16,
      left = 16,
      right = 16,
      bottom = 0,
    },
    height = 24,
    -- bg = '#00000000',
    widget = {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        taglist,
        tasklist,
      },
      music,
      {
        layout = wibox.layout.fixed.horizontal,
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
