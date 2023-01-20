local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')

local settings = require('settings')
local playerctl = require('utils.playerctl')
local menu = require('ui.popups.menu')

local super = 'Mod4'

local function spawn_term(app)
  awful.spawn(settings.terminal .. ' -e ' .. app)
end

local k = awful.key

local keys = { mouse = {}, keyboard = {} }

-- stylua: ignore start

----
-- System
----
awful.keyboard.append_global_keybindings({
  -- Show keybindings
  k(
    { super }, 'F1',
    hotkeys_popup.show_help,
    { description = 'Show this list', group = 'System' }
  ),
  -- Quit Awesome
  k(
    { super, 'Shift' }, 'q',
    awesome.quit,
    { description = 'Quit', group = 'System' }
  ),
  k(
    { super, 'Shift' }, 'r',
    awesome.restart,
    { description = 'Restart Awesome', group = 'System' }
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
})


----
-- Client
----
awful.keyboard.append_global_keybindings({
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
  -- Swap client by direction
  k(
    { super, 'Shift' }, 'k',
    function()
      awful.client.swap.bydirection('up')
    end,
    { description = 'Focus Up', group = 'Client' }
  ),
  k(
    { super, 'Shift' }, 'j',
    function()
      awful.client.swap.bydirection('down')
    end,
    { description = 'Focus Down', group = 'Client' }
  ),
  k(
    { super, 'Shift' }, 'h',
    function()
      awful.client.swap.bydirection('left')
    end,
    { description = 'Focus Left', group = 'Client' }
  ),
  k(
    { super, 'Shift' }, 'l',
    function()
      awful.client.swap.bydirection('right')
    end,
    { description = 'Focus Right', group = 'Client' }
  ),
})

----
-- Screen
----
awful.keyboard.append_global_keybindings({
  k(
    { super, 'Control' }, 'h',
    function()
      awful.screen.focus_bydirection('left')
    end,
    { description = 'Focus Left Screen', group = 'Screen' }
  ),
  k(
    { super, 'Control' }, 'l',
    function()
      awful.screen.focus_bydirection('right')
    end,
    { description = 'Focus Right Screen', group = 'Screen' }
  ),
})

----
-- Layout
----
awful.keyboard.append_global_keybindings({
  k(
    { super }, 'u',
    function()
      awful.layout.inc(-1)
    end,
    { description = 'Previous Layout', group = 'Layout' }
  ),
  k(
    { super }, 'i',
    function()
      awful.layout.inc(1)
    end,
    { description = 'Next Layout', group = 'Layout' }
  ),
  k(
    { super, 'Shift' }, 'u',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = 'Decrease Master Count', group = 'Layout' }
  ),
  k(
    { super, 'Shift' }, 'i',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = 'Increase Master Count', group = 'Layout' }
  ),
  k(
    { super, 'Control' }, 'u',
    function()
      awful.tag.incncol(-1)
    end,
    { description = 'Decrease Column Count', group = 'Layout' }
  ),
  k(
    { super, 'Control' }, 'i',
    function()
      awful.tag.incncol(1)
    end,
    { description = 'Increase Column Count', group = 'Layout' }
  ),
})

----
-- Apps
----
awful.keyboard.append_global_keybindings({
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
})

----
-- Utils
----
awful.keyboard.append_global_keybindings({
  -- Toggle Screenkeys
  k(
    { super }, 'ScrollLock',
    function()
      awful.spawn.with_shell('killall screenkey || screenkey &')
    end,
    { description = 'Toggle Screenkeys', group = 'Utils' }
  ),
})

----
-- Media Controls
----
awful.keyboard.append_global_keybindings({
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
})

----
-- Screenshot
----
awful.keyboard.append_global_keybindings({
  -- Area
  k(
    { super }, 'less',
    function()
      awful.spawn('flameshot gui')
    end,
    { description = 'Screenshot Area', group = 'Capture' }
  ),
})

----
-- Tags
----
awful.keyboard.append_global_keybindings({
  -- Focus Tag
  k({
    modifiers = { super },
    keygroup = "numrow",
    description = 'Switch to Tag',
    group = 'Tags',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end
  }),
  k({
    modifiers = { super, 'Control' },
    keygroup = "numrow",
    description = 'Toggle Tag',
    group = 'Tags',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end
  }),
  k({
    modifiers = { super, 'Shift' },
    keygroup = "numrow",
    description = 'Move Focused to Tag',
    group = 'Tags',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end
  }),
  k({
    modifiers = { super, 'Control', 'Shift' },
    keygroup = "numrow",
    description = 'Toggle Focused on Tag',
    group = 'Tags',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end
  }),
})

awful.mouse.append_global_mousebindings({
  awful.button(
    {}, awful.button.names.RIGHT,
    function()
      menu:toggle()
    end
  )
})

client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings({
    -- Close Window
    k(
      { super }, 'q',
      function(c)
        c:kill()
      end,
      { description = 'Close Window', group = 'window' }
    ),
    -- Toggle Maximized
    k(
      { super }, 'm',
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = 'Toggle Maximized', group = 'window' }
    ),
    -- Toggle Floating
    k(
      { super }, 'f',
      awful.client.floating.toggle,
      { description = 'Toggle Floating', group = 'window' }
    ),
  })
end)

client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings({
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
    ),
  })
end)
-- stylua: ignore end

return keys