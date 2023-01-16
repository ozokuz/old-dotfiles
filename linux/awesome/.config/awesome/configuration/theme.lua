local beautiful = require('beautiful')
local gears = require('gears')

beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
beautiful.useless_gap = 8
beautiful.wibar_opacity = 0.75
