-- Configuration for ASMR Relaxation Game
function love.conf(t)
    -- Game information
    t.title = "ASMR Relaxation"
    t.version = "11.5"
    t.identity = "asmr-relaxation"
    
    -- Window settings for a calming experience
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = true
    t.window.minwidth = 800
    t.window.minheight = 600
    t.window.vsync = 1 -- Smooth 60fps
    t.window.msaa = 4 -- Anti-aliasing for smooth visuals
    t.window.borderless = false
    t.window.centered = true
    t.window.display = 1
    t.window.highdpi = true
    t.window.usedpiscale = true
    
    -- Graphics settings (moved to window section for LÖVE 11.5)
    t.window.gammacorrect = false -- Keep natural colors
    t.window.lowpower = false -- Allow full performance for smooth visuals
    
    -- Audio settings
    t.audio.mixwithsystem = true -- Allow system audio mixing
    
    -- Console for debugging (Windows only)
    t.console = false
    
    -- Modules to load
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false -- Not needed for this game
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false -- Not needed for this game
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.touch = true -- For mobile support
    t.modules.video = false -- Not needed for this game
    t.modules.window = true
    t.modules.thread = false -- Not needed for this game
    t.modules.data = true
    t.modules.filesystem = true
    t.modules.font = true
    t.modules.joystick = false
    t.modules.sensor = false
end
