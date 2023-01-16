local beautiful = require('beautiful')
local gears = require('gears')

beautiful.wallpaper = '/home/' .. os.getenv('USER') .. '/.local/wallpaper.png'

local wallpaper = {}

wallpaper.set = function(s)
  gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

return wallpaper
