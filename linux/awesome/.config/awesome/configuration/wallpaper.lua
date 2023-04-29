local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

beautiful.wallpaper = '/home/' .. os.getenv('USER') .. '/.local/wallpaper.png'

screen.connect_signal('request::wallpaper', function(s)
  awful.wallpaper({
    screen = s,
    widget = {
      image = beautiful.wallpaper,
      upscale = true,
      downscale = true,
      resize = true,
      horizontal_fit_policy = 'fit',
      -- vertical_fit_policy = 'fit',
      widget = wibox.widget.imagebox,
    },
  })
  --[[ awful.wallpaper({
    screen = s,
    widget = {
      {
        image = beautiful.wallpaper,
        upscale = true,
        downscale = true,
        resize = true,
        horizontal_fit_policy = 'fit',
        vertical_fit_policy = 'fit',
        widget = wibox.widget.imagebox,
      },
      valign = 'center',
      halign = 'center',
      tiled = false,
      widget = wibox.container.tile,
    },
  }) ]]
end)
