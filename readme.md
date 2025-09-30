# ASMR Relaxation Game

A soothing, interactive ASMR experience built with LÖVE (Love2D). This game provides a calming environment with gentle visual effects, breathing exercises, and relaxing interactions.

## Features

### 🌟 Visual Effects
- **Floating Particles**: Gentle, colorful particles that drift across the screen
- **Aurora Effect**: Northern lights-style flowing colors in the sky
- **Wave Animations**: Soft, undulating wave patterns
- **Twinkling Stars**: Gentle starfield with twinkling effects
- **Interactive Bubbles**: Soothing bubble animations

### 🧘 Breathing Exercises
- **Guided Breathing**: Visual breathing guide with inhale/hold/exhale/pause phases
- **Breathing Circle**: Pulsing circle that grows and shrinks with your breath
- **Toggle Control**: Press SPACE to enable/disable breathing guide

### 🎮 Interactive Elements
- **Click Effects**: Create ripple effects and particle bursts when clicking
- **Drag Interactions**: Gentle particle trails when dragging the mouse
- **Meditation Circles**: Concentric circles that follow your mouse
- **Touch Points**: Visual feedback for interactions

### 🎨 Color Schemes
- **Blue Theme** (Key 1): Cool, oceanic colors
- **Pink Theme** (Key 2): Warm, sunset colors  
- **Green Theme** (Key 3): Natural, forest colors

## Controls

| Key | Action |
|-----|--------|
| **Mouse Click & Drag** | Create interactive effects |
| **SPACE** | Toggle breathing guide |
| **R** | Reset all effects |
| **C** | Clear interactive effects |
| **1, 2, 3** | Change color schemes |
| **ESC** | Quit game |

## How to Run

### Prerequisites
- Download and install [LÖVE](https://love2d.org/) for your platform

### Running the Game
1. Navigate to the game directory in terminal/command prompt
2. Run: `love .` (on most platforms)
   - Windows: `love.exe .`
   - macOS: Open Terminal, navigate to folder, run `love .`
   - Linux: `love .`

### Alternative Method
1. Drag the entire game folder onto the LÖVE executable
2. Or zip the contents and rename to `.love` file, then open with LÖVE

## Game Design Philosophy

This ASMR game is designed to be:
- **Non-competitive**: No scores, goals, or pressure
- **Meditative**: Focus on breathing and gentle interactions
- **Accessible**: Simple controls that anyone can use
- **Calming**: Soft colors, gentle animations, and soothing effects
- **Interactive**: Responds to user input in satisfying ways

## Technical Details

- Built with LÖVE 12.0
- Pure Lua scripting
- Cross-platform (Windows, macOS, Linux, Android, iOS)
- No external dependencies required
- Optimized for smooth 60fps performance

## Customization

The game is easily customizable by editing `main.lua`:
- Adjust particle counts in `game.settings.particleCount`
- Modify colors in the `game.colors` table
- Change breathing timing in `game.breathing.duration`
- Add new visual effects by extending the particle systems

## Future Enhancements

Potential additions for future versions:
- Audio integration with ambient sounds
- More breathing patterns and exercises
- Additional color schemes and themes
- Save/load user preferences
- Mobile-optimized touch controls
- Guided meditation scripts

## License

This project is open source and available under the same license as LÖVE (zlib license).

---

**Enjoy your relaxing ASMR experience! 🌙✨**