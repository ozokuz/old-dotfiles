local gears = require('gears')
local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local settings = require('settings')
local playerctl = require('utils.playerctl')
local menu = require('configuration.menu')

local super = 'Mod4'

local function spawn_term(app)
  awful.spawn(settings.terminal .. ' -e ' .. app)
end

local k = awful.key

local keys = { mouse = {}, keyboard = {} }

-- stylua: ignore start
keys.keyboard.global = gears.table.join(
----
-- System
----
-- Show keybindings
  k(
    { super }, 'F1',
    hotkeys_popup.show_help,
    { description = 'Show this list', group = 'System' }
  ),
  -- Quit Awesome
  k(
    { super, 'Shift' }, 'q',
    function()
      awesome.quit()
    end,
    { description = 'Quit', group = 'System' }
  ),
  -- Configure Network
  k(
    { super, 'Shift' }, 'w',
    function()
      spawn_term('nmtui')
    end,
    { description = 'Network Configuration', group = 'System' }
  ),
  -- Audio Mixer
  k(
    { super }, 'a',
    function()
      spawn_term('pulsemixer')
    end,
    { description = 'Audio Mixer', group = 'System' }
  ),
  -- Application Launcher
  k(
    { super }, 'space',
    function()
      awful.spawn.with_shell('rofi -modi drun -show drun')
    end,
    { description = 'Application Launcher', group = 'System' }
  ),
  -- Command Runner
  k(
    { super, 'Shift' }, 'space',
    function()
      awful.spawn.with_shell('rofi -modi run -show run')
    end,
    { description = 'Command Runner', group = 'System' }
  ),
  ----
  -- Client
  -- Focus client by direction
  k(
    { super }, 'k',
    function()
      awful.client.focus.bydirection('up')
    end,
    { description = 'Focus Up', group = 'Client' }
  ),
  k(
    { super }, 'j',
    function()
      awful.client.focus.bydirection('down')
    end,
    { description = 'Focus Down', group = 'Client' }
  ),
  k(
    { super }, 'h',
    function()
      awful.client.focus.bydirection('left')
    end,
    { description = 'Focus Left', group = 'Client' }
  ),
  k(
    { super }, 'l',
    function()
      awful.client.focus.bydirection('right')
    end,
    { description = 'Focus Right', group = 'Client' }
  ),
  ----
  -- Apps
  ----
  -- Web Browser
  k(
    { super }, 'w',
    function()
      awful.spawn(settings.browser)
    end,
    { description = 'Web Browser', group = 'Apps' }
  ),
  -- TUI File Manager
  k(
    { super }, 'e',
    function()
      spawn_term('lf')
    end,
    { description = 'TUI File Manager', group = 'Apps' }
  ),
  -- GUI File Manager
  k(
    { super, 'Shift' }, 'e',
    function()
      awful.spawn(settings.gui_file_manager)
    end,
    { description = 'GUI File Manager', group = 'Apps' }
  ),
  -- Task Manager
  k(
    { super }, 'r',
    function()
      awful.spawn(settings.task_manager)
    end,
    { description = 'Task Manager', group = 'Apps' }
  ),
  -- Terminal
  k(
    { super }, 'Return',
    function()
      awful.spawn(settings.terminal)
    end,
    { description = 'Terminal', group = 'Apps' }
  ),
  -- Password Manager
  k(
    { super }, 'x',
    function()
      awful.spawn('bitwarden-desktop')
    end,
    { description = 'Password Manager', group = 'Apps' }
  ),
  -- Authenticator
  k(
    { super, "Shift" }, 'x',
    function()
      awful.spawn('authy')
    end,
    { description = 'Authenticator', group = 'Apps' }
  ),
  -- Utils
  -- Toggle Screenkeys
  k(
    { super }, 'ScrollLock',
    function()
      awful.spawn.with_shell('killall screenkey || screenkey &')
    end,
    { description = 'Toggle Screenkeys', group = 'Utils' }
  ),
  -- Media Controls
  -- Play / Pause
  k(
    {}, 'XF86AudioPlay',
    function()
      playerctl:play_pause()
    end,
    { description = 'Play / Pause', group = 'Media' }
  ),
  -- Previous
  k(
    {}, 'XF86AudioPrev',
    function()
      playerctl:previous()
    end,
    { description = 'Previous', group = 'Media' }
  ),
  -- Next
  k(
    {}, 'XF86AudioNext',
    function()
      playerctl:next()
    end,
    { description = 'Next', group = 'Media' }
  ),
  -- Screenshot
  -- Area
  k(
    { super }, 'less',
    function()
      awful.spawn('flameshot gui')
    end,
    { description = 'Screenshot Area', group = 'Capture' }
  )
)

for i = 1, 9 do
  keys.keyboard.global = gears.table.join(
    keys.keyboard.global,
    -- Focus Tag
    k(
      { super }, '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = 'Switch to Tag #', group = 'Tags' }
    ),
    -- Toggle Tag
    k(
      { super, 'Control' }, '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = 'Toggle Tag #', group = 'Tags' }
    ),
    -- Move Focused to Tag
    k(
      { super, 'Shift' }, '#' .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = 'Move Focused to Tag #', group = 'Tags' }
    ),
    -- Toggle Focused on Tag
    k(
      { super, 'Control', 'Shift' }, '#' .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = 'Toggle Focused on Tag #', group = 'Tags' }
    )
  )
end

keys.mouse.global = gears.table.join(
  awful.button(
    {}, awful.button.names.RIGHT,
    function()
      menu:toggle()
    end
  )
)

keys.keyboard.client = gears.table.join(
  k(
    { super }, 'm',
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = 'Toggle Maximized', group = 'window' }
  ),
  k(
    { super }, 'f',
    awful.client.floating.toggle,
    { description = 'Toggle Floating', group = 'window' }
  ),
  k(
    { super }, 'q',
    function(c)
      c:kill()
    end,
    { description = 'Close Window', group = 'window' }
  )
)

keys.mouse.client = gears.table.join(
  awful.button(
    {}, awful.button.names.LEFT,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end
  ),
  awful.button(
    { super }, awful.button.names.LEFT,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
      awful.mouse.client.move(c)
    end
  ),
  awful.button(
    { super }, awful.button.names.RIGHT,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
      awful.mouse.client.resize(c)
    end
  )
)

keys.mouse.taglist = gears.table.join(
  awful.button(
    {}, awful.button.names.LEFT,
    function(t)
      t:view_only()
    end
  ),
  awful.button(
    { super }, awful.button.names.LEFT,
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end
  ),
  awful.button(
    {}, awful.button.names.RIGHT,
    awful.tag.viewtoggle
  ),
  awful.button(
    { super }, awful.button.names.RIGHT,
    function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end
  )
)
-- stylua: ignore end

return keys
