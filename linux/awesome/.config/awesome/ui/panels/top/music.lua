local wibox = require('wibox')
local playerctl = require('utils.playerctl')

local music = wibox.widget({
  markup = 'Nothing Playing',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
})

playerctl:connect_signal('metadata', function(_, title, artist)
  music:set_markup_silently(artist .. ' - ' .. title)
end)

return music
