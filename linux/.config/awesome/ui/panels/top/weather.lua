local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')

local weather = wibox.widget({
  markup = 'Unknown',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
})

gears.timer({
  timeout = 3600,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async(
      { 'curl', '-fSLo', '-', 'https://wttr.in/?format=%c%20%t' },
      function(out)
        weather:set_markup_silently(out)
      end
    )
  end,
})

return weather
