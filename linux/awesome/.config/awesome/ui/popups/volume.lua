local gears = require('gears')
local awful = require('awful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local wibox = require('wibox')

local icons = {
  muted = ' \u{f075f} ',
  low = ' \u{fa7e} ',
  mid = ' \u{fa7f} ',
  high = ' \u{fa7d} ',
}

-- View
local icon = wibox.widget({
  text = icons.low,
  font = 'FiraCode Nerd Font 16',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
})

local header = wibox.widget({
  text = 'Volume',
  font = 'FiraCode Nerd Font Bold 12',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
})

local value = wibox.widget({
  text = '0%',
  font = 'FiraCode Nerd Font Bold 12',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
})

local slider = wibox.widget({
  nil,
  {
    id = 'volume_slider',
    bar_shape = gears.shape.rounded_rect,
    bar_height = dpi(24),
    bar_color = '#ffffff20',
    bar_active_color = '#f2f2f2EE',
    handle_color = '#ffffff',
    handle_shape = gears.shape.circle,
    handle_width = dpi(24),
    handle_border_color = '#00000012',
    handle_border_width = dpi(1),
    maximum = 100,
    widget = wibox.widget.slider,
  },
  nil,
  expand = 'none',
  layout = wibox.layout.align.vertical,
})

local layout = {
  {
    {
      layout = wibox.layout.fixed.vertical,
      {
        {
          layout = wibox.layout.align.horizontal,
          nil,
          icon,
          nil,
        },
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(5),
          {
            layout = wibox.layout.align.horizontal,
            expand = 'none',
            header,
            nil,
            value,
          },
          slider,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.vertical,
      },
    },
    left = dpi(24),
    right = dpi(24),
    widget = wibox.container.margin,
  },
  bg = '#0c0e0f',
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
}

-- Controller

local popup_hide_timer = gears.timer({
  timeout = 2,
  autostart = false,
  callback = function()
    local focused = awful.screen.focused()
    focused.volume_popup.visible = false
  end,
})

local volume = slider.volume_slider

volume:connect_signal('property::value', function()
  local level = volume:get_value()
  awful.spawn('pamixer --set-volume ' .. level, false)

  value.text = level .. '%'
end)

awesome.connect_signal('module::volume_popup::set_level', function(level)
  if level > 75 then
    icon.text = icons.high
  elseif level > 25 then
    icon.text = icons.mid
  else
    icon.text = icons.low
  end
  volume:set_value(level)
  awful.placement.centered(awful.screen.focused().volume_popup)
  awful.screen.focused().volume_popup.visible = true
  popup_hide_timer:again()
end)

awesome.connect_signal('module::volume_popup::set_mute', function(muted)
  local level = volume:get_value()
  if muted then
    icon.text = icons.muted
  elseif level > 75 then
    icon.text = icons.high
  elseif level > 25 then
    icon.text = icons.mid
  else
    icon.text = icons.low
  end
  awful.placement.centered(awful.screen.focused().volume_popup)
  awful.screen.focused().volume_popup.visible = true
  popup_hide_timer:again()
end)

local volume_popup_height = dpi(250)
local volume_popup_width = dpi(250)

screen.connect_signal('request::desktop_decoration', function(s)
  s.volume_popup = awful.popup({
    type = 'notification',
    screen = s,
    height = volume_popup_height,
    width = volume_popup_width,
    maximum_height = volume_popup_height,
    maximum_width = volume_popup_width,
    bg = '#00000000',
    offset = dpi(5),
    ontop = true,
    visible = false,
    preferred_anchors = 'middle',
    preferred_positions = { 'left', 'right', 'top', 'bottom' },
    widget = layout,
  })

  --[[ s.volume_popup:connect_signal('mouse::enter', function()
    popup_hide_timer:stop()
  end)

  s.volume_popup:connect_signal('mouse::leave', function()
    popup_hide_timer:start()
  end) ]]
end)
