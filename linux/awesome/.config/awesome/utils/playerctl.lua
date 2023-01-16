local bling = require('modules.bling')

local instance = nil

local function new()
  return bling.signal.playerctl.lib({
    player = { 'spotify' },
  })
end

if not instance then
  instance = new()
end

return instance
