-- ASMR Relaxation Game
-- A comprehensive soothing interactive experience

local game = {
    -- Game state
    state = "menu", -- menu, playing, settings, meditation
    time = 0,
    fadeTime = 0,
    fadeDirection = 1,
    breathing = {
        phase = "inhale", -- inhale, hold, exhale, pause
        timer = 0,
        duration = 4, -- seconds per phase
        intensity = 0.5
    },
    
    -- Visual elements
    particles = {},
    aurora = {}, -- Northern lights effect
    waves = {}, -- Gentle wave animations
    colors = {
        background = {0.05, 0.05, 0.15, 1},
        primary = {0.3, 0.7, 0.9, 1},
        secondary = {0.8, 0.3, 0.7, 1},
        accent = {0.4, 0.9, 0.6, 1},
        aurora = {
            {0.2, 0.8, 0.4, 0.6},
            {0.4, 0.2, 0.8, 0.6},
            {0.8, 0.4, 0.2, 0.6}
        }
    },
    
    -- Ultimate Audio System
    audio = {
        enabled = true,
        masterVolume = 1.0,
        ambientVolume = 0.8,
        effectsVolume = 0.9,
        musicVolume = 0.7,
        spatialAudio = true,
        reverb = 0.3,
        sounds = {
            -- Ambient sounds
            oceanWaves = nil,
            rain = nil,
            wind = nil,
            forest = nil,
            fire = nil,
            thunder = nil,
            birds = nil,
            crickets = nil,
            
            -- Interactive sounds
            ripple = nil,
            click = nil,
            whoosh = nil,
            sparkle = nil,
            chime = nil,
            bell = nil,
            gong = nil,
            crystal = nil,
            
            -- Breathing & meditation
            breathingIn = nil,
            breathingOut = nil,
            heartbeat = nil,
            meditation = nil,
            om = nil,
            
            -- Nature sounds
            waterfall = nil,
            stream = nil,
            leaves = nil,
            windChimes = nil,
            singingBowl = nil
        },
        sources = {},
        activeSounds = {},
        audioContext = nil
    },
    
    -- Interactive elements
    bubbles = {},
    stars = {},
    mousePos = {x = 0, y = 0},
    mousePressed = false,
    rippleEffects = {}, -- Click ripple effects
    meditationCircles = {}, -- Concentric circles for meditation
    touchPoints = {}, -- Touch/click interaction points
    
    -- Ultimate Visual Effects System
    fireflies = {}, -- Floating firefly particles
    sparkles = {}, -- Magical sparkle effects
    clouds = {}, -- Floating cloud formations
    rain = {}, -- Gentle rain particles
    snow = {}, -- Snowflake particles
    leaves = {}, -- Falling leaves
    butterflies = {}, -- Fluttering butterflies
    energyOrbs = {}, -- Glowing energy orbs
    lightRays = {}, -- Sunlight rays
    mist = {}, -- Atmospheric mist
    
    -- Advanced Visual Effects
    auroraBorealis = {}, -- Northern lights
    shootingStars = {}, -- Shooting star effects
    meteors = {}, -- Meteor shower
    comets = {}, -- Comet trails
    nebula = {}, -- Cosmic nebula effects
    galaxies = {}, -- Spiral galaxy formations
    planets = {}, -- Floating planets
    stars = {}, -- Twinkling stars
    constellations = {}, -- Star constellations
    cosmicDust = {}, -- Cosmic dust particles
    
    -- Nature Effects
    waterfalls = {}, -- Waterfall effects
    rivers = {}, -- Flowing river effects
    mountains = {}, -- Mountain silhouettes
    trees = {}, -- Animated trees
    flowers = {}, -- Blooming flowers
    grass = {}, -- Waving grass
    sand = {}, -- Sand particles
    waves = {}, -- Ocean waves
    
    -- Magical Effects
    fairyDust = {}, -- Magical fairy dust
    crystals = {}, -- Glowing crystals
    portals = {}, -- Mystical portals
    auras = {}, -- Energy auras
    mandalas = {}, -- Sacred mandalas
    chakras = {}, -- Energy chakras
    auras = {}, -- Spiritual auras
    spirits = {}, -- Ethereal spirits
    
    -- Weather Effects
    lightning = {}, -- Lightning bolts
    thunder = {}, -- Thunder effects
    fog = {}, -- Atmospheric fog
    mist = {}, -- Mystical mist
    steam = {}, -- Steam effects
    smoke = {}, -- Smoke particles
    embers = {}, -- Fire embers
    sparks = {}, -- Electric sparks
    
    -- Settings
    settings = {
        volume = 0.7,
        particleCount = 80,
        breathingEnabled = true,
        colorScheme = 1,
        meditationMode = false,
        visualEffects = true,
        particleDensity = 1.0,
        animationSpeed = 1.0,
        autoMode = false,
        soundEnabled = true
    },
    
    -- Meditation sequences
    meditation = {
        currentSequence = 1,
        sequences = {
            {
                name = "Deep Breathing",
                duration = 300, -- 5 minutes
                phases = {"inhale", "hold", "exhale", "pause"},
                phaseDurations = {4, 2, 6, 2}
            },
            {
                name = "Body Scan",
                duration = 600, -- 10 minutes
                phases = {"inhale", "exhale"},
                phaseDurations = {6, 8}
            },
            {
                name = "Mindful Awareness",
                duration = 900, -- 15 minutes
                phases = {"inhale", "hold", "exhale"},
                phaseDurations = {5, 3, 7}
            }
        }
    },
    
    -- Audio system
    audio = {
        oscillators = {},
        noise = {},
        reverb = {},
        volume = 0.3
    }
}

-- Initialize the game
function love.load()
    love.window.setTitle("ASMR Relaxation - Complete Edition")
    
    -- Set up graphics
    love.graphics.setDefaultFilter("linear", "linear")
    
    -- Initialize audio system
    initializeAudio()
    
    -- Start with menu
    game.state = "menu"
    
    -- Create particles
    for i = 1, game.settings.particleCount do
        table.insert(game.particles, {
            x = math.random() * love.graphics.getWidth(),
            y = math.random() * love.graphics.getHeight(),
            vx = (math.random() - 0.5) * 20,
            vy = (math.random() - 0.5) * 20,
            size = math.random() * 3 + 1,
            alpha = math.random() * 0.5 + 0.3,
            color = math.random() * 3 + 1
        })
    end
    
    -- Create interactive bubbles
    for i = 1, 8 do
        table.insert(game.bubbles, {
            x = math.random() * love.graphics.getWidth(),
            y = math.random() * love.graphics.getHeight(),
            size = math.random() * 30 + 20,
            pulse = 0,
            targetSize = math.random() * 30 + 20,
            color = math.random() * 3 + 1
        })
    end
    
    -- Create floating stars
    for i = 1, 15 do
        table.insert(game.stars, {
            x = math.random() * love.graphics.getWidth(),
            y = math.random() * love.graphics.getHeight(),
            size = math.random() * 2 + 1,
            twinkle = math.random() * math.pi * 2,
            speed = math.random() * 0.02 + 0.01
        })
    end
    
    -- Create aurora effect
    for i = 1, 8 do
        table.insert(game.aurora, {
            x = math.random() * love.graphics.getWidth(),
            y = math.random() * love.graphics.getHeight() * 0.3,
            width = math.random() * 200 + 100,
            height = math.random() * 50 + 20,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.01 + 0.005,
            color = math.random() * 3 + 1
        })
    end
    
    -- Create wave effects
    for i = 1, 5 do
        table.insert(game.waves, {
            y = love.graphics.getHeight() * (0.7 + i * 0.06),
            amplitude = math.random() * 30 + 10,
            frequency = math.random() * 0.02 + 0.01,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.005 + 0.002
        })
    end
    
    -- Load sounds (placeholder - would need actual audio files)
    -- game.sounds.ambient = love.audio.newSource("sounds/ambient.ogg", "stream")
    -- game.sounds.click = love.audio.newSource("sounds/click.ogg", "static")
    -- game.sounds.whoosh = love.audio.newSource("sounds/whoosh.ogg", "static")
end

-- Initialize audio system
function initializeAudio()
    if game.audio.enabled then
        -- Initialize audio context
        game.audio.audioContext = love.audio.newSource()
        
        -- Create procedural ASMR sounds
        createProceduralSounds()
        
        -- Start ambient audio
        startAmbientAudio()
        
        -- Test sound to verify audio is working
        love.timer.sleep(0.1) -- Small delay to ensure audio is ready
        playSound("chime", 1.0, 1.0)
        
        print("🎵 Ultimate Audio System Initialized!")
    end
end

-- Create procedural ASMR sounds
function createProceduralSounds()
    local sampleRate = 44100
    local duration = 2.0
    local samples = sampleRate * duration
    
    -- Ocean waves
    local waveData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local wave = math.sin(t * 0.5) * math.exp(-t * 0.3) * 0.3
        waveData[i] = wave + (math.random() * 2 - 1) * 0.05
    end
    game.audio.sounds.oceanWaves = createSoundFromData(waveData, sampleRate)
    
    -- Rain
    local rainData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local rain = (math.random() * 2 - 1) * 0.2 * math.sin(t * 2000)
        rainData[i] = rain
    end
    game.audio.sounds.rain = createSoundFromData(rainData, sampleRate)
    
    -- Wind
    local windData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local wind = (math.random() * 2 - 1) * 0.1 * math.sin(t * 100)
        windData[i] = wind
    end
    game.audio.sounds.wind = createSoundFromData(windData, sampleRate)
    
    -- Ripple effect
    local rippleData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local ripple = math.sin(t * 800) * math.exp(-t * 2) * 0.5
        rippleData[i] = ripple
    end
    game.audio.sounds.ripple = createSoundFromData(rippleData, sampleRate)
    
    -- Chime
    local chimeData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local chime = math.sin(t * 440) * math.exp(-t * 1.5) * 0.3
        chimeData[i] = chime
    end
    game.audio.sounds.chime = createSoundFromData(chimeData, sampleRate)
    
    -- Click sound
    local clickData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local click = math.sin(t * 1000) * math.exp(-t * 10) * 0.5
        clickData[i] = click
    end
    game.audio.sounds.click = createSoundFromData(clickData, sampleRate)
    
    -- Breathing in
    local breathInData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local breath = math.sin(t * 0.5) * math.exp(-t * 0.5) * 0.4
        breathInData[i] = breath
    end
    game.audio.sounds.breathingIn = createSoundFromData(breathInData, sampleRate)
    
    -- Breathing out
    local breathOutData = {}
    for i = 1, samples do
        local t = i / sampleRate
        local breath = math.sin(t * 0.3) * math.exp(-t * 0.8) * 0.4
        breathOutData[i] = breath
    end
    game.audio.sounds.breathingOut = createSoundFromData(breathOutData, sampleRate)
end

-- Create sound from data
function createSoundFromData(data, sampleRate)
    local soundData = love.sound.newSoundData(#data, sampleRate, 16, 1)
    for i = 1, #data do
        soundData:setSample(i - 1, data[i])
    end
    return love.audio.newSource(soundData, "static")
end

-- Start ambient audio
function startAmbientAudio()
    if game.audio.sounds.oceanWaves then
        game.audio.sounds.oceanWaves:setLooping(true)
        game.audio.sounds.oceanWaves:setVolume(game.audio.ambientVolume * game.audio.masterVolume)
        game.audio.sounds.oceanWaves:play()
        print("🌊 Ocean waves started")
    end
    
    if game.audio.sounds.rain then
        game.audio.sounds.rain:setLooping(true)
        game.audio.sounds.rain:setVolume(game.audio.ambientVolume * 0.5 * game.audio.masterVolume)
        game.audio.sounds.rain:play()
        print("🌧️ Rain started")
    end
end

-- Play sound effect
function playSound(soundName, volume, pitch)
    if game.audio.enabled and game.audio.sounds[soundName] then
        -- Initialize activeSounds if not exists
        if not game.audio.activeSounds then
            game.audio.activeSounds = {}
        end
        
        local source = game.audio.sounds[soundName]:clone()
        local finalVolume = (volume or 1.0) * game.audio.effectsVolume * game.audio.masterVolume
        source:setVolume(finalVolume)
        source:setPitch(pitch or 1.0)
        source:play()
        
        -- Debug output
        print("🔊 Playing sound: " .. soundName .. " at volume: " .. finalVolume)
        
        -- Add to active sounds
        table.insert(game.audio.activeSounds, source)
    else
        print("❌ Sound not available: " .. tostring(soundName))
    end
end

-- Update audio system
function updateAudio(dt)
    -- Initialize activeSounds if not exists
    if not game.audio.activeSounds then
        game.audio.activeSounds = {}
    end
    
    -- Clean up finished sounds
    for i = #game.audio.activeSounds, 1, -1 do
        local source = game.audio.activeSounds[i]
        if not source:isPlaying() then
            table.remove(game.audio.activeSounds, i)
        end
    end
end

-- Generate procedural ASMR audio
function generateASMRAudio()
    if not game.settings.soundEnabled then return end
    
    -- Generate gentle tones
    for i, osc in ipairs(game.audio.oscillators) do
        if osc.active then
            local sample = math.sin(osc.phase) * osc.volume * game.audio.volume
            -- In a real implementation, this would feed into an audio buffer
            osc.phase = osc.phase + (osc.frequency * 2 * math.pi / 44100)
            if osc.phase > 2 * math.pi then
                osc.phase = osc.phase - 2 * math.pi
            end
        end
    end
end

-- Menu system
function drawMenu()
    local width, height = love.graphics.getDimensions()
    
    -- Animated background with particles
    love.graphics.setColor(game.colors.background[1], game.colors.background[2], game.colors.background[3], 0.95)
    love.graphics.rectangle("fill", 0, 0, width, height)
    
    -- Draw background particles
    for i, particle in ipairs(game.particles) do
        if particle.alpha > 0.1 then
            local color = game.colors.primary
            if particle.color > 2 then
                color = game.colors.secondary
            elseif particle.color > 1 then
                color = game.colors.accent
            end
            love.graphics.setColor(color[1], color[2], color[3], particle.alpha * 0.3)
            love.graphics.circle("fill", particle.x, particle.y, particle.size * 0.5)
        end
    end
    
    -- Draw aurora background
    for i, aurora in ipairs(game.aurora) do
        local color = game.colors.aurora[aurora.color] or game.colors.aurora[1]
        local alpha = (math.sin(aurora.phase) + 1) * 0.1 + 0.05
        love.graphics.setColor(color[1], color[2], color[3], alpha)
        love.graphics.rectangle("fill", aurora.x, aurora.y, aurora.width, aurora.height)
    end
    
    -- Title with gradient effect
    local titleY = height * 0.15
    love.graphics.setColor(1, 1, 1, 0.95)
    love.graphics.setFont(love.graphics.newFont(48))
    love.graphics.printf("ASMR RELAXATION", 0, titleY, width, "center")
    
    -- Subtitle with pulsing effect
    local pulse = (math.sin(game.time * 2) + 1) * 0.1 + 0.8
    love.graphics.setColor(0.7, 0.9, 1, pulse)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("Complete Edition", 0, titleY + 60, width, "center")
    
    -- Menu options with modern design
    local menuY = height * 0.4
    local options = {
        {text = "Start Relaxation", icon = "🌊"},
        {text = "Meditation Mode", icon = "🧘"},
        {text = "Settings", icon = "⚙️"},
        {text = "Quit", icon = "❌"}
    }
    
    for i, option in ipairs(options) do
        local y = menuY + (i - 1) * 80
        local x = width * 0.5
        local buttonWidth = 300
        local buttonHeight = 50
        local buttonX = x - buttonWidth * 0.5
        
        -- Button background with hover effect
        local hover = math.abs(game.mousePos.y - y) < 25 and math.abs(game.mousePos.x - x) < buttonWidth * 0.5
        local alpha = hover and 0.8 or 0.4
        local scale = hover and 1.05 or 1.0
        
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.rectangle("fill", buttonX, y - 20, buttonWidth, buttonHeight, 10)
        
        -- Button border
        love.graphics.setColor(0.3, 0.7, 0.9, 0.6)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", buttonX, y - 20, buttonWidth, buttonHeight, 10)
        
        -- Button text with icon
        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.setFont(love.graphics.newFont(20))
        love.graphics.printf(option.icon .. " " .. option.text, buttonX, y - 5, buttonWidth, "center")
    end
    
    -- Version info
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.printf("v1.0 • LÖVE 11.5", 0, height - 40, width, "center")
    
    -- Instructions with animation
    local instructionAlpha = (math.sin(game.time * 3) + 1) * 0.3 + 0.4
    love.graphics.setColor(1, 1, 1, instructionAlpha)
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.printf("Click to select • Use mouse to navigate", 0, height - 80, width, "center")
end

function drawSettings()
    local width, height = love.graphics.getDimensions()
    
    -- Animated background
    love.graphics.setColor(game.colors.background[1], game.colors.background[2], game.colors.background[3], 0.95)
    love.graphics.rectangle("fill", 0, 0, width, height)
    
    -- Draw subtle background particles
    for i, particle in ipairs(game.particles) do
        if particle.alpha > 0.05 then
            local color = game.colors.primary
            love.graphics.setColor(color[1], color[2], color[3], particle.alpha * 0.1)
            love.graphics.circle("fill", particle.x, particle.y, particle.size * 0.3)
        end
    end
    
    -- Title with back button
    love.graphics.setColor(1, 1, 1, 0.95)
    love.graphics.setFont(love.graphics.newFont(36))
    love.graphics.printf("⚙️ SETTINGS", 0, height * 0.1, width, "center")
    
    -- Settings panel
    local panelWidth = 600
    local panelHeight = 500
    local panelX = (width - panelWidth) * 0.5
    local panelY = height * 0.2
    
    -- Panel background
    love.graphics.setColor(0.1, 0.1, 0.2, 0.8)
    love.graphics.rectangle("fill", panelX, panelY, panelWidth, panelHeight, 15)
    
    -- Panel border
    love.graphics.setColor(0.3, 0.7, 0.9, 0.6)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", panelX, panelY, panelWidth, panelHeight, 15)
    
    -- Settings options with sliders and toggles
    local settingsY = panelY + 50
    local settings = {
        {name = "Particle Count", value = game.settings.particleCount, min = 20, max = 150, type = "slider"},
        {name = "Breathing Guide", value = game.settings.breathingEnabled, type = "toggle"},
        {name = "Sound Effects", value = game.settings.soundEnabled, type = "toggle"},
        {name = "Color Scheme", value = game.settings.colorScheme, min = 1, max = 3, type = "selector"},
        {name = "Volume", value = game.settings.volume, min = 0, max = 1, type = "slider"}
    }
    
    for i, setting in ipairs(settings) do
        local y = settingsY + (i - 1) * 70
        local x = panelX + 50
        
        -- Setting name
        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.printf(setting.name, x, y, 200, "left")
        
        if setting.type == "slider" then
            -- Slider background
            local sliderX = x + 250
            local sliderY = y + 10
            local sliderWidth = 200
            local sliderHeight = 20
            
            love.graphics.setColor(0.2, 0.2, 0.3, 0.8)
            love.graphics.rectangle("fill", sliderX, sliderY, sliderWidth, sliderHeight, 10)
            
            -- Slider fill
            local fillWidth = (setting.value - setting.min) / (setting.max - setting.min) * sliderWidth
            love.graphics.setColor(0.3, 0.7, 0.9, 0.8)
            love.graphics.rectangle("fill", sliderX, sliderY, fillWidth, sliderHeight, 10)
            
            -- Slider handle
            local handleX = sliderX + fillWidth - 10
            love.graphics.setColor(1, 1, 1, 0.9)
            love.graphics.circle("fill", handleX, sliderY + sliderHeight * 0.5, 8)
            
            -- Value display
            love.graphics.setColor(1, 1, 1, 0.7)
            love.graphics.setFont(love.graphics.newFont(14))
            love.graphics.printf(tostring(setting.value), sliderX + sliderWidth + 10, y + 5, 50, "left")
            
        elseif setting.type == "toggle" then
            -- Toggle button
            local toggleX = x + 250
            local toggleY = y + 5
            local toggleWidth = 60
            local toggleHeight = 30
            
            local toggleColor = setting.value and {0.3, 0.8, 0.4} or {0.5, 0.5, 0.5}
            love.graphics.setColor(toggleColor[1], toggleColor[2], toggleColor[3], 0.8)
            love.graphics.rectangle("fill", toggleX, toggleY, toggleWidth, toggleHeight, 15)
            
            -- Toggle text
            love.graphics.setColor(1, 1, 1, 0.9)
            love.graphics.setFont(love.graphics.newFont(14))
            love.graphics.printf(setting.value and "ON" or "OFF", toggleX, toggleY + 8, toggleWidth, "center")
            
        elseif setting.type == "selector" then
            -- Color scheme selector
            local selectorX = x + 250
            local selectorY = y + 5
            local selectorWidth = 200
            local selectorHeight = 30
            
            love.graphics.setColor(0.2, 0.2, 0.3, 0.8)
            love.graphics.rectangle("fill", selectorX, selectorY, selectorWidth, selectorHeight, 15)
            
            -- Color scheme options
            local schemes = {"Ocean", "Sunset", "Forest"}
            love.graphics.setColor(1, 1, 1, 0.9)
            love.graphics.setFont(love.graphics.newFont(14))
            love.graphics.printf(schemes[setting.value], selectorX, selectorY + 8, selectorWidth, "center")
        end
    end
    
    -- Back button
    local backButtonY = panelY + panelHeight - 60
    local backButtonX = panelX + 50
    local backButtonWidth = 200
    local backButtonHeight = 40
    
    love.graphics.setColor(0.3, 0.7, 0.9, 0.8)
    love.graphics.rectangle("fill", backButtonX, backButtonY, backButtonWidth, backButtonHeight, 10)
    
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.printf("← Back to Menu", backButtonX, backButtonY + 10, backButtonWidth, "center")
    
    -- Instructions
    love.graphics.setColor(1, 1, 1, 0.6)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.printf("Click to adjust settings • ESC to go back", 0, height - 30, width, "center")
end

-- Update game logic
function love.update(dt)
    game.time = game.time + dt
    game.fadeTime = game.fadeTime + dt * game.fadeDirection
    
    -- Generate ASMR audio
    generateASMRAudio()
    
    -- Handle different game states
    if game.state == "menu" or game.state == "settings" then
        return -- Skip game logic for menus
    end
    
    -- Update breathing
    if game.settings.breathingEnabled then
        game.breathing.timer = game.breathing.timer + dt
        
        if game.breathing.timer >= game.breathing.duration then
            game.breathing.timer = 0
            if game.breathing.phase == "inhale" then
                game.breathing.phase = "hold"
                playSound("breathingIn", 0.5, 1.0)
            elseif game.breathing.phase == "hold" then
                game.breathing.phase = "exhale"
            elseif game.breathing.phase == "exhale" then
                game.breathing.phase = "pause"
                playSound("breathingOut", 0.5, 1.0)
            else
                game.breathing.phase = "inhale"
            end
        end
    end
    
    -- Update particles
    for i, particle in ipairs(game.particles) do
        particle.x = particle.x + particle.vx * dt
        particle.y = particle.y + particle.vy * dt
        
        -- Wrap around screen
        if particle.x < 0 then particle.x = love.graphics.getWidth() end
        if particle.x > love.graphics.getWidth() then particle.x = 0 end
        if particle.y < 0 then particle.y = love.graphics.getHeight() end
        if particle.y > love.graphics.getHeight() then particle.y = 0 end
        
        -- Gentle floating motion
        particle.vy = particle.vy + math.sin(game.time + i) * 10 * dt
        particle.vx = particle.vx + math.cos(game.time + i) * 5 * dt
        
        -- Dampen velocity
        particle.vx = particle.vx * 0.99
        particle.vy = particle.vy * 0.99
    end
    
    -- Update bubbles
    for i, bubble in ipairs(game.bubbles) do
        bubble.pulse = bubble.pulse + dt * 2
        bubble.size = bubble.targetSize + math.sin(bubble.pulse) * 5
        
        -- Gentle movement
        bubble.x = bubble.x + math.sin(game.time + i) * 10 * dt
        bubble.y = bubble.y + math.cos(game.time + i) * 8 * dt
        
        -- Keep on screen
        bubble.x = (bubble.x + love.graphics.getWidth()) % love.graphics.getWidth()
        bubble.y = (bubble.y + love.graphics.getHeight()) % love.graphics.getHeight()
    end
    
    -- Update stars
    for i, star in ipairs(game.stars) do
        star.twinkle = star.twinkle + star.speed
        star.x = star.x + math.sin(game.time + i) * 5 * dt
        star.y = star.y + math.cos(game.time + i) * 3 * dt
        
        -- Keep on screen
        star.x = (star.x + love.graphics.getWidth()) % love.graphics.getWidth()
        star.y = (star.y + love.graphics.getHeight()) % love.graphics.getHeight()
    end
    
    -- Update aurora
    for i, aurora in ipairs(game.aurora) do
        aurora.phase = aurora.phase + aurora.speed
        aurora.x = aurora.x + math.sin(game.time + i) * 20 * dt
        aurora.y = aurora.y + math.cos(game.time + i) * 10 * dt
        
        -- Keep on screen
        aurora.x = (aurora.x + love.graphics.getWidth()) % love.graphics.getWidth()
        aurora.y = math.max(0, math.min(aurora.y, love.graphics.getHeight() * 0.4))
    end
    
    -- Update waves
    for i, wave in ipairs(game.waves) do
        wave.phase = wave.phase + wave.speed
    end
    
    -- Update ripple effects
    for i = #game.rippleEffects, 1, -1 do
        local ripple = game.rippleEffects[i]
        ripple.timer = ripple.timer + dt
        ripple.size = ripple.size + ripple.speed * dt
        ripple.alpha = ripple.alpha - ripple.fadeSpeed * dt
        
        if ripple.alpha <= 0 then
            table.remove(game.rippleEffects, i)
        end
    end
    
    -- Update meditation circles
    for i, circle in ipairs(game.meditationCircles) do
        circle.phase = circle.phase + circle.speed * dt
        circle.size = circle.baseSize + math.sin(circle.phase) * circle.pulseSize
    end
    
    -- Update touch points
    for i = #game.touchPoints, 1, -1 do
        local point = game.touchPoints[i]
        point.timer = point.timer + dt
        point.alpha = point.alpha - point.fadeSpeed * dt
        
        if point.alpha <= 0 then
            table.remove(game.touchPoints, i)
        end
    end
    
    -- Update ultimate visual effects
    updateUltimateVisualEffects(dt)
    
    -- Update audio system
    updateAudio(dt)
    
    -- Update mouse position
    game.mousePos.x, game.mousePos.y = love.mouse.getPosition()
end

-- Draw the game
function love.draw()
    local width, height = love.graphics.getDimensions()
    
    -- Handle different game states
    if game.state == "menu" then
        drawMenu()
        return
    elseif game.state == "settings" then
        drawSettings()
        return
    end
    
    -- Breathing background effect
    local breathIntensity = 0
    if game.settings.breathingEnabled then
        if game.breathing.phase == "inhale" then
            breathIntensity = game.breathing.timer / game.breathing.duration
        elseif game.breathing.phase == "exhale" then
            breathIntensity = 1 - (game.breathing.timer / game.breathing.duration)
        end
    end
    
    -- Draw background with breathing effect
    local bgColor = game.colors.background
    love.graphics.setColor(bgColor[1] + breathIntensity * 0.1, 
                          bgColor[2] + breathIntensity * 0.1, 
                          bgColor[3] + breathIntensity * 0.1, 
                          bgColor[4])
    love.graphics.rectangle("fill", 0, 0, width, height)
    
    -- Draw particles
    for i, particle in ipairs(game.particles) do
        local color = game.colors.primary
        if particle.color > 2 then
            color = game.colors.secondary
        elseif particle.color > 1 then
            color = game.colors.accent
        end
        
        love.graphics.setColor(color[1], color[2], color[3], particle.alpha)
        love.graphics.circle("fill", particle.x, particle.y, particle.size)
    end
    
    -- Draw bubbles
    for i, bubble in ipairs(game.bubbles) do
        local color = game.colors.primary
        if bubble.color > 2 then
            color = game.colors.secondary
        elseif bubble.color > 1 then
            color = game.colors.accent
        end
        
        love.graphics.setColor(color[1], color[2], color[3], 0.3)
        love.graphics.circle("fill", bubble.x, bubble.y, bubble.size)
        love.graphics.setColor(color[1], color[2], color[3], 0.6)
        love.graphics.circle("line", bubble.x, bubble.y, bubble.size)
    end
    
    -- Draw aurora
    for i, aurora in ipairs(game.aurora) do
        local color = game.colors.aurora[aurora.color] or game.colors.aurora[1]
        local alpha = (math.sin(aurora.phase) + 1) * 0.3 + 0.2
        love.graphics.setColor(color[1], color[2], color[3], alpha)
        
        -- Draw aurora as flowing rectangles
        local waveOffset = math.sin(aurora.phase) * 20
        love.graphics.rectangle("fill", aurora.x + waveOffset, aurora.y, aurora.width, aurora.height)
    end
    
    -- Draw waves
    love.graphics.setColor(0.2, 0.4, 0.6, 0.3)
    for i, wave in ipairs(game.waves) do
        local points = {}
        for x = 0, width, 10 do
            local y = wave.y + math.sin(x * wave.frequency + wave.phase) * wave.amplitude
            table.insert(points, x)
            table.insert(points, y)
        end
        if #points > 2 then
            love.graphics.line(points)
        end
    end
    
    -- Draw stars
    for i, star in ipairs(game.stars) do
        local twinkle = (math.sin(star.twinkle) + 1) * 0.5
        love.graphics.setColor(1, 1, 1, twinkle * 0.8)
        love.graphics.circle("fill", star.x, star.y, star.size)
    end
    
    -- Draw ripple effects
    for i, ripple in ipairs(game.rippleEffects) do
        love.graphics.setColor(1, 1, 1, ripple.alpha)
        love.graphics.circle("line", ripple.x, ripple.y, ripple.size)
        love.graphics.circle("line", ripple.x, ripple.y, ripple.size * 0.7)
        love.graphics.circle("line", ripple.x, ripple.y, ripple.size * 0.4)
    end
    
    -- Draw meditation circles
    for i, circle in ipairs(game.meditationCircles) do
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.circle("line", circle.x, circle.y, circle.size)
        love.graphics.circle("line", circle.x, circle.y, circle.size * 0.8)
        love.graphics.circle("line", circle.x, circle.y, circle.size * 0.6)
    end
    
    -- Draw touch points
    for i, point in ipairs(game.touchPoints) do
        love.graphics.setColor(1, 1, 1, point.alpha)
        love.graphics.circle("fill", point.x, point.y, 3)
        love.graphics.circle("line", point.x, point.y, 8)
    end
    
    -- Draw ultimate visual effects
    drawUltimateVisualEffects()
    
    -- Draw breathing guide
    if game.settings.breathingEnabled then
        local centerX, centerY = width * 0.5, height * 0.8
        local circleSize = 50 + breathIntensity * 30
        
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.circle("line", centerX, centerY, circleSize)
        
        -- Breathing text
        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.printf("Breathe " .. game.breathing.phase:upper(), 
                           0, centerY + 60, width, "center")
    end
    
    -- Enhanced UI with progress indicators
    local uiY = 20
    local uiHeight = 40
    
    -- Background panel for UI
    love.graphics.setColor(0.1, 0.1, 0.2, 0.8)
    love.graphics.rectangle("fill", 10, uiY, width - 20, uiHeight, 10)
    
    -- Title with status
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.printf("🌊 ASMR Relaxation", 20, uiY + 5, 300, "left")
    
    -- Status indicators
    local statusX = width - 200
    local statusY = uiY + 5
    
    -- Breathing indicator
    if game.settings.breathingEnabled then
        local breathAlpha = (math.sin(game.time * 2) + 1) * 0.3 + 0.4
        love.graphics.setColor(0.3, 0.8, 0.4, breathAlpha)
        love.graphics.circle("fill", statusX, statusY + 15, 6)
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.printf("Breathing", statusX + 15, statusY + 10, 80, "left")
    end
    
    -- Meditation indicator
    if game.settings.meditationMode then
        love.graphics.setColor(0.8, 0.3, 0.7, 0.8)
        love.graphics.circle("fill", statusX + 100, statusY + 15, 6)
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.printf("Meditation", statusX + 115, statusY + 10, 80, "left")
    end
    
    -- Meditation mode info
    if game.settings.meditationMode then
        local sequence = game.meditation.sequences[game.meditation.currentSequence]
        love.graphics.setColor(0.8, 0.3, 0.7, 0.9)
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.printf("🧘 " .. sequence.name, 0, 80, width, "center")
    end
    
    -- Bottom controls panel
    local controlsY = height - 50
    love.graphics.setColor(0.1, 0.1, 0.2, 0.8)
    love.graphics.rectangle("fill", 10, controlsY, width - 20, 40, 10)
    
    -- Control instructions
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.printf("SPACE: Breathing • M: Meditation • S: Settings • ESC: Menu", 20, controlsY + 10, width - 40, "left")
    
    -- Particle count indicator
    love.graphics.setColor(1, 1, 1, 0.6)
    love.graphics.setFont(love.graphics.newFont(12))
    love.graphics.printf("Particles: " .. #game.particles, width - 150, controlsY + 12, 140, "right")
    
    -- Draw mouse interaction
    if game.mousePressed then
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.circle("fill", game.mousePos.x, game.mousePos.y, 20)
    end
end

-- Handle mouse input
function love.mousepressed(x, y, button)
    if button == 1 then -- Left click
        -- Handle menu clicks
        if game.state == "menu" then
            local width, height = love.graphics.getDimensions()
            local menuY = height * 0.4
            local buttonWidth = 300
            local buttonHeight = 50
            
            for i = 1, 4 do
                local buttonY = menuY + (i - 1) * 80
                local buttonX = width * 0.5 - buttonWidth * 0.5
                
                if x >= buttonX and x <= buttonX + buttonWidth and 
                   y >= buttonY - 20 and y <= buttonY + buttonHeight - 20 then
                    if i == 1 then
                        game.state = "playing"
                        game.fadeDirection = 1
                    elseif i == 2 then
                        game.state = "meditation"
                        game.settings.meditationMode = true
                    elseif i == 3 then
                        game.state = "settings"
                    elseif i == 4 then
                        love.event.quit()
                    end
                    break
                end
            end
            return
        elseif game.state == "settings" then
            local height = love.graphics.getHeight()
            local settingsY = height * 0.4
            local clickY = y - settingsY
            
            if clickY >= 0 and clickY < 50 then
                game.settings.particleCount = math.min(200, game.settings.particleCount + 10)
            elseif clickY >= 50 and clickY < 100 then
                game.settings.breathingEnabled = not game.settings.breathingEnabled
            elseif clickY >= 100 and clickY < 150 then
                game.settings.soundEnabled = not game.settings.soundEnabled
            elseif clickY >= 150 and clickY < 200 then
                game.settings.colorScheme = (game.settings.colorScheme % 3) + 1
            elseif clickY >= 200 and clickY < 250 then
                game.state = "menu"
            end
            return
        end
        
        game.mousePressed = true
        
        -- Create ripple effect
        table.insert(game.rippleEffects, {
            x = x,
            y = y,
            size = 0,
            speed = 200,
            alpha = 0.8,
            fadeSpeed = 0.5,
            timer = 0
        })
        
        -- Play ripple sound
        playSound("ripple", 0.8, 1.0)
        
        -- Create touch point
        table.insert(game.touchPoints, {
            x = x,
            y = y,
            alpha = 1.0,
            fadeSpeed = 0.3,
            timer = 0
        })
        
        -- Create particle burst
        for i = 1, 8 do
            table.insert(game.particles, {
                x = x,
                y = y,
                vx = (math.random() - 0.5) * 150,
                vy = (math.random() - 0.5) * 150,
                size = math.random() * 3 + 1,
                alpha = 0.9,
                color = math.random() * 3 + 1
            })
        end
        
        -- Create meditation circle if held
        if love.mouse.isDown(1) then
            table.insert(game.meditationCircles, {
                x = x,
                y = y,
                baseSize = 20,
                size = 20,
                pulseSize = 10,
                phase = 0,
                speed = 2
            })
        end
        
        -- Play click sound
        playSound("click", 0.6, 1.0)
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        game.mousePressed = false
    end
end

function love.mousemoved(x, y, dx, dy)
    if game.mousePressed then
        -- Create gentle trail
        if math.random() < 0.4 then
            table.insert(game.particles, {
                x = x,
                y = y,
                vx = -dx * 0.3,
                vy = -dy * 0.3,
                size = math.random() * 2 + 1,
                alpha = 0.6,
                color = math.random() * 3 + 1
            })
        end
        
        -- Update meditation circles position
        for i, circle in ipairs(game.meditationCircles) do
            circle.x = x
            circle.y = y
        end
    end
end

-- Handle keyboard input
function love.keypressed(key)
    if key == "space" then
        game.settings.breathingEnabled = not game.settings.breathingEnabled
        game.breathing.timer = 0
        game.breathing.phase = "inhale"
    elseif key == "escape" then
        if game.state == "menu" then
            love.event.quit()
        else
            game.state = "menu"
        end
    elseif key == "r" then
        -- Reset all effects
        game.particles = {}
        game.rippleEffects = {}
        game.meditationCircles = {}
        game.touchPoints = {}
        
        -- Recreate particles
        for i = 1, game.settings.particleCount do
            table.insert(game.particles, {
                x = math.random() * love.graphics.getWidth(),
                y = math.random() * love.graphics.getHeight(),
                vx = (math.random() - 0.5) * 20,
                vy = (math.random() - 0.5) * 20,
                size = math.random() * 3 + 1,
                alpha = math.random() * 0.5 + 0.3,
                color = math.random() * 3 + 1
            })
        end
    elseif key == "c" then
        -- Clear all interactive effects
        game.rippleEffects = {}
        game.meditationCircles = {}
        game.touchPoints = {}
    elseif key == "1" then
        -- Change color scheme
        game.settings.colorScheme = 1
        game.colors.background = {0.05, 0.05, 0.15, 1}
        game.colors.primary = {0.3, 0.7, 0.9, 1}
    elseif key == "2" then
        -- Change color scheme
        game.settings.colorScheme = 2
        game.colors.background = {0.15, 0.05, 0.05, 1}
        game.colors.primary = {0.9, 0.3, 0.7, 1}
    elseif key == "3" then
        -- Change color scheme
        game.settings.colorScheme = 3
        game.colors.background = {0.05, 0.15, 0.05, 1}
        game.colors.primary = {0.3, 0.9, 0.7, 1}
    elseif key == "m" then
        -- Toggle meditation mode
        game.settings.meditationMode = not game.settings.meditationMode
        if game.settings.meditationMode then
            game.meditation.currentSequence = (game.meditation.currentSequence % #game.meditation.sequences) + 1
        end
    elseif key == "s" then
        -- Open settings
        game.state = "settings"
    elseif key == "t" then
        -- Test sound
        playSound("chime", 1.0, 1.0)
        print("🔊 Testing sound...")
    elseif key == "a" then
        -- Toggle audio
        game.audio.enabled = not game.audio.enabled
        print("🔊 Audio " .. (game.audio.enabled and "enabled" or "disabled"))
    end
end

-- Handle window resize
function love.resize(w, h)
    -- Adjust particle positions if they're off screen
    for i, particle in ipairs(game.particles) do
        if particle.x > w then particle.x = w end
        if particle.y > h then particle.y = h end
    end
end

-- Generate enhanced visual effects
function generateVisualEffects()
    local width, height = love.graphics.getDimensions()
    
    -- Fireflies
    for i = 1, 15 do
        table.insert(game.fireflies, {
            x = math.random() * width,
            y = math.random() * height,
            vx = (math.random() - 0.5) * 30,
            vy = (math.random() - 0.5) * 30,
            size = math.random() * 2 + 1,
            alpha = math.random() * 0.8 + 0.2,
            glow = math.random() * 0.5 + 0.5,
            life = math.random() * 20 + 10
        })
    end
    
    -- Sparkles
    for i = 1, 20 do
        table.insert(game.sparkles, {
            x = math.random() * width,
            y = math.random() * height,
            vx = (math.random() - 0.5) * 40,
            vy = (math.random() - 0.5) * 40,
            size = math.random() * 4 + 2,
            alpha = math.random() * 0.9 + 0.1,
            rotation = 0,
            life = math.random() * 15 + 5
        })
    end
    
    -- Clouds
    for i = 1, 8 do
        table.insert(game.clouds, {
            x = math.random() * width,
            y = math.random() * height * 0.3,
            vx = (math.random() - 0.5) * 10,
            vy = (math.random() - 0.5) * 5,
            size = math.random() * 50 + 30,
            alpha = math.random() * 0.3 + 0.1,
            life = math.random() * 30 + 20
        })
    end
    
    -- Energy orbs
    for i = 1, 5 do
        table.insert(game.energyOrbs, {
            x = math.random() * width,
            y = math.random() * height,
            vx = (math.random() - 0.5) * 15,
            vy = (math.random() - 0.5) * 15,
            size = math.random() * 8 + 5,
            alpha = math.random() * 0.7 + 0.3,
            pulse = 0,
            life = math.random() * 25 + 15
        })
    end
end

-- Update enhanced visual effects
function updateVisualEffects(dt)
    -- Update fireflies
    for i = #game.fireflies, 1, -1 do
        local firefly = game.fireflies[i]
        firefly.x = firefly.x + firefly.vx * dt
        firefly.y = firefly.y + firefly.vy * dt
        firefly.life = firefly.life - dt
        firefly.glow = firefly.glow + dt * 2
        
        if firefly.life <= 0 then
            table.remove(game.fireflies, i)
        end
    end
    
    -- Update sparkles
    for i = #game.sparkles, 1, -1 do
        local sparkle = game.sparkles[i]
        sparkle.x = sparkle.x + sparkle.vx * dt
        sparkle.y = sparkle.y + sparkle.vy * dt
        sparkle.rotation = sparkle.rotation + dt * 3
        sparkle.life = sparkle.life - dt
        
        if sparkle.life <= 0 then
            table.remove(game.sparkles, i)
        end
    end
    
    -- Update energy orbs
    for i = #game.energyOrbs, 1, -1 do
        local orb = game.energyOrbs[i]
        orb.x = orb.x + orb.vx * dt
        orb.y = orb.y + orb.vy * dt
        orb.pulse = orb.pulse + dt * 2
        orb.life = orb.life - dt
        
        if orb.life <= 0 then
            table.remove(game.energyOrbs, i)
        end
    end
end

-- Draw enhanced visual effects
function drawVisualEffects()
    -- Draw fireflies
    for i, firefly in ipairs(game.fireflies) do
        local glowAlpha = (math.sin(firefly.glow) + 1) * 0.3 + 0.4
        love.graphics.setColor(1, 1, 0.3, firefly.alpha * glowAlpha)
        love.graphics.circle("fill", firefly.x, firefly.y, firefly.size)
        love.graphics.setColor(1, 1, 0.6, firefly.alpha * glowAlpha * 0.5)
        love.graphics.circle("fill", firefly.x, firefly.y, firefly.size * 2)
    end
    
    -- Draw sparkles
    for i, sparkle in ipairs(game.sparkles) do
        love.graphics.push()
        love.graphics.translate(sparkle.x, sparkle.y)
        love.graphics.rotate(sparkle.rotation)
        love.graphics.setColor(1, 1, 1, sparkle.alpha)
        love.graphics.rectangle("fill", -sparkle.size * 0.5, -sparkle.size * 0.5, sparkle.size, sparkle.size)
        love.graphics.pop()
    end
    
    -- Draw energy orbs
    for i, orb in ipairs(game.energyOrbs) do
        local pulseSize = orb.size + math.sin(orb.pulse) * 3
        love.graphics.setColor(0.3, 0.8, 1, orb.alpha)
        love.graphics.circle("fill", orb.x, orb.y, pulseSize)
        love.graphics.setColor(0.6, 0.9, 1, orb.alpha * 0.5)
        love.graphics.circle("fill", orb.x, orb.y, pulseSize * 1.5)
    end
end

-- Save user settings
function saveSettings()
    local settingsData = {
        volume = game.settings.volume,
        particleCount = game.settings.particleCount,
        breathingEnabled = game.settings.breathingEnabled,
        colorScheme = game.settings.colorScheme,
        visualEffects = game.settings.visualEffects,
        particleDensity = game.settings.particleDensity,
        animationSpeed = game.settings.animationSpeed,
        soundEnabled = game.settings.soundEnabled
    }
    
    local success, err = pcall(function()
        love.filesystem.write("settings.json", json.encode(settingsData))
    end)
    
    if not success then
        print("Failed to save settings: " .. tostring(err))
    end
end

-- Load user settings
function loadSettings()
    local success, data = pcall(function()
        local content = love.filesystem.read("settings.json")
        return json.decode(content)
    end)
    
    if success and data then
        game.settings.volume = data.volume or game.settings.volume
        game.settings.particleCount = data.particleCount or game.settings.particleCount
        game.settings.breathingEnabled = data.breathingEnabled ~= nil and data.breathingEnabled or game.settings.breathingEnabled
        game.settings.colorScheme = data.colorScheme or game.settings.colorScheme
        game.settings.visualEffects = data.visualEffects ~= nil and data.visualEffects or game.settings.visualEffects
        game.settings.particleDensity = data.particleDensity or game.settings.particleDensity
        game.settings.animationSpeed = data.animationSpeed or game.settings.animationSpeed
        game.settings.soundEnabled = data.soundEnabled ~= nil and data.soundEnabled or game.settings.soundEnabled
    end
end

-- JSON encoding/decoding (simple implementation)
json = {}
function json.encode(data)
    local function encodeValue(value)
        if type(value) == "string" then
            return '"' .. value:gsub('"', '\\"') .. '"'
        elseif type(value) == "number" then
            return tostring(value)
        elseif type(value) == "boolean" then
            return value and "true" or "false"
        elseif type(value) == "table" then
            local result = "{"
            local first = true
            for k, v in pairs(value) do
                if not first then result = result .. "," end
                result = result .. '"' .. tostring(k) .. '":' .. encodeValue(v)
                first = false
            end
            return result .. "}"
        end
        return "null"
    end
    return encodeValue(data)
end

function json.decode(str)
    -- Simple JSON decoder (basic implementation)
    local function parseValue(str, pos)
        pos = pos or 1
        while pos <= #str and str:sub(pos, pos):match("%s") do
            pos = pos + 1
        end
        
        if pos > #str then return nil, pos end
        
        local char = str:sub(pos, pos)
        if char == '"' then
            local start = pos + 1
            local endPos = str:find('"', start)
            if not endPos then return nil, pos end
            return str:sub(start, endPos - 1), endPos + 1
        elseif char:match("%d") or char == "-" then
            local start = pos
            while pos <= #str and (str:sub(pos, pos):match("%d") or str:sub(pos, pos) == "." or str:sub(pos, pos) == "-") do
                pos = pos + 1
            end
            return tonumber(str:sub(start, pos - 1)), pos
        elseif char == "t" then
            if str:sub(pos, pos + 3) == "true" then
                return true, pos + 4
            end
        elseif char == "f" then
            if str:sub(pos, pos + 4) == "false" then
                return false, pos + 5
            end
        elseif char == "n" then
            if str:sub(pos, pos + 3) == "null" then
                return nil, pos + 4
            end
        elseif char == "{" then
            local result = {}
            pos = pos + 1
            while pos <= #str and str:sub(pos, pos) ~= "}" do
                while pos <= #str and str:sub(pos, pos):match("%s") do
                    pos = pos + 1
                end
                if pos > #str then break end
                
                local key, newPos = parseValue(str, pos)
                if not key then break end
                pos = newPos
                
                while pos <= #str and str:sub(pos, pos):match("%s") do
                    pos = pos + 1
                end
                if pos > #str or str:sub(pos, pos) ~= ":" then break end
                pos = pos + 1
                
                local value, newPos = parseValue(str, pos)
                if value == nil then break end
                pos = newPos
                
                result[key] = value
                
                while pos <= #str and str:sub(pos, pos):match("%s") do
                    pos = pos + 1
                end
                if pos <= #str and str:sub(pos, pos) == "," then
                    pos = pos + 1
                end
            end
            if pos <= #str and str:sub(pos, pos) == "}" then
                pos = pos + 1
            end
            return result, pos
        end
        
        return nil, pos
    end
    
    return parseValue(str)
end

-- Ultimate Visual Effects System
function generateUltimateVisualEffects()
    local width, height = love.graphics.getDimensions()
    
    -- Generate cosmic effects
    generateCosmicEffects(width, height)
    
    -- Generate nature effects
    generateNatureEffects(width, height)
    
    -- Generate magical effects
    generateMagicalEffects(width, height)
    
    -- Generate weather effects
    generateWeatherEffects(width, height)
    
    print("✨ Ultimate Visual Effects System Initialized!")
end

-- Generate cosmic effects
function generateCosmicEffects(width, height)
    -- Aurora Borealis
    for i = 1, 5 do
        table.insert(game.auroraBorealis, {
            x = math.random() * width,
            y = math.random() * height * 0.3,
            width = math.random() * 200 + 100,
            height = math.random() * 50 + 20,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.5 + 0.1,
            color = math.random(3),
            alpha = math.random() * 0.3 + 0.2
        })
    end
    
    -- Shooting stars
    for i = 1, 10 do
        table.insert(game.shootingStars, {
            x = math.random() * width,
            y = math.random() * height * 0.5,
            vx = math.random() * 100 + 50,
            vy = math.random() * 50 + 25,
            size = math.random() * 3 + 1,
            alpha = math.random() * 0.8 + 0.2,
            life = math.random() * 3 + 1,
            trail = {}
        })
    end
    
    -- Meteors
    for i = 1, 5 do
        table.insert(game.meteors, {
            x = math.random() * width,
            y = math.random() * height * 0.3,
            vx = math.random() * 80 + 40,
            vy = math.random() * 40 + 20,
            size = math.random() * 5 + 2,
            alpha = math.random() * 0.9 + 0.1,
            life = math.random() * 5 + 2,
            glow = math.random() * 0.5 + 0.5
        })
    end
    
    -- Nebula
    for i = 1, 3 do
        table.insert(game.nebula, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 150 + 100,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.3 + 0.1,
            color = math.random(3),
            alpha = math.random() * 0.2 + 0.1
        })
    end
    
    -- Planets
    for i = 1, 8 do
        table.insert(game.planets, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 20 + 10,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.2 + 0.05,
            color = math.random(3),
            alpha = math.random() * 0.6 + 0.4,
            orbit = math.random() * 100 + 50
        })
    end
end

-- Generate nature effects
function generateNatureEffects(width, height)
    -- Waterfalls
    for i = 1, 3 do
        table.insert(game.waterfalls, {
            x = math.random() * width,
            y = math.random() * height * 0.5,
            width = math.random() * 30 + 20,
            height = math.random() * 100 + 50,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 2 + 1,
            alpha = math.random() * 0.4 + 0.3
        })
    end
    
    -- Rivers
    for i = 1, 2 do
        table.insert(game.rivers, {
            x = 0,
            y = math.random() * height * 0.7 + height * 0.3,
            width = width,
            height = math.random() * 20 + 10,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 1 + 0.5,
            alpha = math.random() * 0.3 + 0.2
        })
    end
    
    -- Trees
    for i = 1, 15 do
        table.insert(game.trees, {
            x = math.random() * width,
            y = height - math.random() * height * 0.3,
            size = math.random() * 40 + 20,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.5 + 0.1,
            sway = math.random() * 0.3 + 0.1,
            alpha = math.random() * 0.8 + 0.2
        })
    end
    
    -- Flowers
    for i = 1, 25 do
        table.insert(game.flowers, {
            x = math.random() * width,
            y = height - math.random() * height * 0.4,
            size = math.random() * 8 + 4,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.5 + 0.1,
            color = math.random(3),
            alpha = math.random() * 0.9 + 0.1
        })
    end
end

-- Generate magical effects
function generateMagicalEffects(width, height)
    -- Fairy dust
    for i = 1, 30 do
        table.insert(game.fairyDust, {
            x = math.random() * width,
            y = math.random() * height,
            vx = (math.random() - 0.5) * 20,
            vy = (math.random() - 0.5) * 20,
            size = math.random() * 2 + 1,
            alpha = math.random() * 0.8 + 0.2,
            life = math.random() * 10 + 5,
            glow = math.random() * 0.5 + 0.5
        })
    end
    
    -- Crystals
    for i = 1, 12 do
        table.insert(game.crystals, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 15 + 8,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.3 + 0.1,
            color = math.random(3),
            alpha = math.random() * 0.9 + 0.1,
            pulse = math.random() * 0.5 + 0.5
        })
    end
    
    -- Portals
    for i = 1, 3 do
        table.insert(game.portals, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 40 + 20,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.5 + 0.2,
            alpha = math.random() * 0.6 + 0.3,
            rotation = 0
        })
    end
    
    -- Mandalas
    for i = 1, 5 do
        table.insert(game.mandalas, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 60 + 30,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.2 + 0.05,
            alpha = math.random() * 0.4 + 0.2,
            rotation = 0
        })
    end
end

-- Generate weather effects
function generateWeatherEffects(width, height)
    -- Lightning
    for i = 1, 3 do
        table.insert(game.lightning, {
            x = math.random() * width,
            y = 0,
            targetX = math.random() * width,
            targetY = height,
            alpha = math.random() * 0.8 + 0.2,
            life = math.random() * 0.5 + 0.1,
            intensity = math.random() * 0.5 + 0.5
        })
    end
    
    -- Fog
    for i = 1, 8 do
        table.insert(game.fog, {
            x = math.random() * width,
            y = math.random() * height,
            size = math.random() * 100 + 50,
            alpha = math.random() * 0.3 + 0.1,
            phase = math.random() * math.pi * 2,
            speed = math.random() * 0.2 + 0.05
        })
    end
    
    -- Steam
    for i = 1, 15 do
        table.insert(game.steam, {
            x = math.random() * width,
            y = height - math.random() * height * 0.3,
            vx = (math.random() - 0.5) * 10,
            vy = -math.random() * 20 - 10,
            size = math.random() * 8 + 4,
            alpha = math.random() * 0.6 + 0.2,
            life = math.random() * 8 + 4
        })
    end
end

-- Update ultimate visual effects
function updateUltimateVisualEffects(dt)
    -- Update cosmic effects
    updateCosmicEffects(dt)
    
    -- Update nature effects
    updateNatureEffects(dt)
    
    -- Update magical effects
    updateMagicalEffects(dt)
    
    -- Update weather effects
    updateWeatherEffects(dt)
end

-- Update cosmic effects
function updateCosmicEffects(dt)
    -- Update aurora borealis
    for i, aurora in ipairs(game.auroraBorealis) do
        aurora.phase = aurora.phase + aurora.speed * dt
        aurora.x = aurora.x + math.sin(aurora.phase) * 10 * dt
    end
    
    -- Update shooting stars
    for i = #game.shootingStars, 1, -1 do
        local star = game.shootingStars[i]
        star.x = star.x + star.vx * dt
        star.y = star.y + star.vy * dt
        star.life = star.life - dt
        
        if star.life <= 0 then
            table.remove(game.shootingStars, i)
        end
    end
    
    -- Update meteors
    for i = #game.meteors, 1, -1 do
        local meteor = game.meteors[i]
        meteor.x = meteor.x + meteor.vx * dt
        meteor.y = meteor.y + meteor.vy * dt
        meteor.life = meteor.life - dt
        meteor.glow = meteor.glow + dt * 2
        
        if meteor.life <= 0 then
            table.remove(game.meteors, i)
        end
    end
    
    -- Update planets
    for i, planet in ipairs(game.planets) do
        planet.phase = planet.phase + planet.speed * dt
        planet.x = planet.x + math.cos(planet.phase) * planet.orbit * dt * 0.1
        planet.y = planet.y + math.sin(planet.phase) * planet.orbit * dt * 0.1
    end
end

-- Update nature effects
function updateNatureEffects(dt)
    -- Update waterfalls
    for i, waterfall in ipairs(game.waterfalls) do
        waterfall.phase = waterfall.phase + waterfall.speed * dt
    end
    
    -- Update rivers
    for i, river in ipairs(game.rivers) do
        river.phase = river.phase + river.speed * dt
    end
    
    -- Update trees
    for i, tree in ipairs(game.trees) do
        tree.phase = tree.phase + tree.speed * dt
    end
    
    -- Update flowers
    for i, flower in ipairs(game.flowers) do
        flower.phase = flower.phase + flower.speed * dt
    end
end

-- Update magical effects
function updateMagicalEffects(dt)
    -- Update fairy dust
    for i = #game.fairyDust, 1, -1 do
        local dust = game.fairyDust[i]
        dust.x = dust.x + dust.vx * dt
        dust.y = dust.y + dust.vy * dt
        dust.life = dust.life - dt
        dust.glow = dust.glow + dt * 3
        
        if dust.life <= 0 then
            table.remove(game.fairyDust, i)
        end
    end
    
    -- Update crystals
    for i, crystal in ipairs(game.crystals) do
        crystal.phase = crystal.phase + crystal.speed * dt
        crystal.pulse = crystal.pulse + dt * 2
    end
    
    -- Update portals
    for i, portal in ipairs(game.portals) do
        portal.phase = portal.phase + portal.speed * dt
        portal.rotation = portal.rotation + dt * 0.5
    end
    
    -- Update mandalas
    for i, mandala in ipairs(game.mandalas) do
        mandala.phase = mandala.phase + mandala.speed * dt
        mandala.rotation = mandala.rotation + dt * 0.1
    end
end

-- Update weather effects
function updateWeatherEffects(dt)
    -- Update lightning
    for i = #game.lightning, 1, -1 do
        local bolt = game.lightning[i]
        bolt.life = bolt.life - dt
        
        if bolt.life <= 0 then
            table.remove(game.lightning, i)
        end
    end
    
    -- Update fog
    for i, fog in ipairs(game.fog) do
        fog.phase = fog.phase + fog.speed * dt
        fog.x = fog.x + math.sin(fog.phase) * 5 * dt
    end
    
    -- Update steam
    for i = #game.steam, 1, -1 do
        local steam = game.steam[i]
        steam.x = steam.x + steam.vx * dt
        steam.y = steam.y + steam.vy * dt
        steam.life = steam.life - dt
        
        if steam.life <= 0 then
            table.remove(game.steam, i)
        end
    end
end

-- Draw ultimate visual effects
function drawUltimateVisualEffects()
    -- Draw cosmic effects
    drawCosmicEffects()
    
    -- Draw nature effects
    drawNatureEffects()
    
    -- Draw magical effects
    drawMagicalEffects()
    
    -- Draw weather effects
    drawWeatherEffects()
end

-- Draw cosmic effects
function drawCosmicEffects()
    -- Draw aurora borealis
    for i, aurora in ipairs(game.auroraBorealis) do
        local color = game.colors.aurora[aurora.color] or game.colors.aurora[1]
        local alpha = (math.sin(aurora.phase) + 1) * 0.3 + 0.2
        love.graphics.setColor(color[1], color[2], color[3], alpha)
        love.graphics.rectangle("fill", aurora.x, aurora.y, aurora.width, aurora.height)
    end
    
    -- Draw shooting stars
    for i, star in ipairs(game.shootingStars) do
        love.graphics.setColor(1, 1, 1, star.alpha)
        love.graphics.circle("fill", star.x, star.y, star.size)
        love.graphics.setColor(0.8, 0.9, 1, star.alpha * 0.5)
        love.graphics.circle("fill", star.x, star.y, star.size * 2)
    end
    
    -- Draw meteors
    for i, meteor in ipairs(game.meteors) do
        local glowAlpha = (math.sin(meteor.glow) + 1) * 0.3 + 0.4
        love.graphics.setColor(1, 0.8, 0.3, meteor.alpha * glowAlpha)
        love.graphics.circle("fill", meteor.x, meteor.y, meteor.size)
        love.graphics.setColor(1, 0.9, 0.6, meteor.alpha * glowAlpha * 0.5)
        love.graphics.circle("fill", meteor.x, meteor.y, meteor.size * 1.5)
    end
    
    -- Draw planets
    for i, planet in ipairs(game.planets) do
        local color = game.colors.aurora[planet.color] or game.colors.aurora[1]
        love.graphics.setColor(color[1], color[2], color[3], planet.alpha)
        love.graphics.circle("fill", planet.x, planet.y, planet.size)
        love.graphics.setColor(color[1], color[2], color[3], planet.alpha * 0.5)
        love.graphics.circle("fill", planet.x, planet.y, planet.size * 1.2)
    end
end

-- Draw nature effects
function drawNatureEffects()
    -- Draw waterfalls
    for i, waterfall in ipairs(game.waterfalls) do
        local alpha = (math.sin(waterfall.phase) + 1) * 0.3 + 0.2
        love.graphics.setColor(0.3, 0.7, 1, alpha)
        love.graphics.rectangle("fill", waterfall.x, waterfall.y, waterfall.width, waterfall.height)
    end
    
    -- Draw rivers
    for i, river in ipairs(game.rivers) do
        local alpha = (math.sin(river.phase) + 1) * 0.2 + 0.1
        love.graphics.setColor(0.2, 0.6, 0.9, alpha)
        love.graphics.rectangle("fill", river.x, river.y, river.width, river.height)
    end
    
    -- Draw trees
    for i, tree in ipairs(game.trees) do
        local sway = math.sin(tree.phase) * tree.sway
        love.graphics.setColor(0.2, 0.6, 0.2, tree.alpha)
        love.graphics.rectangle("fill", tree.x + sway, tree.y, tree.size * 0.3, tree.size)
    end
    
    -- Draw flowers
    for i, flower in ipairs(game.flowers) do
        local color = game.colors.aurora[flower.color] or game.colors.aurora[1]
        love.graphics.setColor(color[1], color[2], color[3], flower.alpha)
        love.graphics.circle("fill", flower.x, flower.y, flower.size)
    end
end

-- Draw magical effects
function drawMagicalEffects()
    -- Draw fairy dust
    for i, dust in ipairs(game.fairyDust) do
        local glowAlpha = (math.sin(dust.glow) + 1) * 0.3 + 0.4
        love.graphics.setColor(1, 1, 0.8, dust.alpha * glowAlpha)
        love.graphics.circle("fill", dust.x, dust.y, dust.size)
        love.graphics.setColor(1, 1, 0.9, dust.alpha * glowAlpha * 0.5)
        love.graphics.circle("fill", dust.x, dust.y, dust.size * 1.5)
    end
    
    -- Draw crystals
    for i, crystal in ipairs(game.crystals) do
        local pulseSize = crystal.size + math.sin(crystal.pulse) * 3
        local color = game.colors.aurora[crystal.color] or game.colors.aurora[1]
        love.graphics.setColor(color[1], color[2], color[3], crystal.alpha)
        love.graphics.circle("fill", crystal.x, crystal.y, pulseSize)
        love.graphics.setColor(color[1], color[2], color[3], crystal.alpha * 0.5)
        love.graphics.circle("fill", crystal.x, crystal.y, pulseSize * 1.3)
    end
    
    -- Draw portals
    for i, portal in ipairs(game.portals) do
        love.graphics.push()
        love.graphics.translate(portal.x, portal.y)
        love.graphics.rotate(portal.rotation)
        love.graphics.setColor(0.8, 0.3, 0.9, portal.alpha)
        love.graphics.circle("fill", 0, 0, portal.size)
        love.graphics.setColor(0.9, 0.5, 1, portal.alpha * 0.5)
        love.graphics.circle("fill", 0, 0, portal.size * 1.2)
        love.graphics.pop()
    end
    
    -- Draw mandalas
    for i, mandala in ipairs(game.mandalas) do
        love.graphics.push()
        love.graphics.translate(mandala.x, mandala.y)
        love.graphics.rotate(mandala.rotation)
        love.graphics.setColor(1, 1, 1, mandala.alpha)
        love.graphics.circle("line", 0, 0, mandala.size)
        love.graphics.circle("line", 0, 0, mandala.size * 0.8)
        love.graphics.circle("line", 0, 0, mandala.size * 0.6)
        love.graphics.pop()
    end
end

-- Draw weather effects
function drawWeatherEffects()
    -- Draw lightning
    for i, bolt in ipairs(game.lightning) do
        love.graphics.setColor(1, 1, 1, bolt.alpha * bolt.intensity)
        love.graphics.setLineWidth(3)
        love.graphics.line(bolt.x, bolt.y, bolt.targetX, bolt.targetY)
    end
    
    -- Draw fog
    for i, fog in ipairs(game.fog) do
        love.graphics.setColor(0.8, 0.8, 0.8, fog.alpha)
        love.graphics.circle("fill", fog.x, fog.y, fog.size)
    end
    
    -- Draw steam
    for i, steam in ipairs(game.steam) do
        love.graphics.setColor(0.9, 0.9, 0.9, steam.alpha)
        love.graphics.circle("fill", steam.x, steam.y, steam.size)
    end
end
