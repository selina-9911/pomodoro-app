# Pomodoro - macOS Menu Bar Timer

A minimalist Pomodoro timer that lives in your macOS menu bar. Built with SwiftUI and AppKit.

## Features

- Lives in the macOS menu bar (status bar)
- Customizable focus and break durations
- Desktop notifications when sessions complete
- Sound notifications
- Simple, clean interface with a custom color palette
- Settings persistence using UserDefaults

## Demo

<img src="demo.gif" alt="Pomodoro Demo" width="50%">

## Requirements

- macOS 13.0 or later
- Xcode 15.0 or later (only needed if building from source)

## Installation

### Download (No Xcode Required)

1. Download the latest release from [Releases](https://github.com/selina-9911/pomodoro-app/releases)
2. Unzip `Pomodoro.app.zip`
3. Move `Pomodoro.app` to your Applications folder (optional)
4. Double-click to run

**First-time setup:** macOS will warn about an unidentified developer. To open:
- Right-click on `Pomodoro.app` → **Open**
- Click **Open** in the security dialog
- The app will launch (this only needs to be done once)

### Build from Source

### Quick Start (Command Line)

1. Clone this repository:
   ```bash
   git clone https://github.com/selina-9911/pomodoro-app.git
   cd pomodoro-app
   ```

2. Build the project once:
   ```bash
   xcodebuild -project Pomodoro.xcodeproj -scheme Pomodoro -configuration Debug
   ```

3. (Optional) Set up a command-line launcher for easy access:
   ```bash
   mkdir -p ~/.local/bin

   # Create launcher script (update APP_PATH to your clone location)
   cat > ~/.local/bin/pomodoro << 'EOF'
   #!/bin/zsh
   APP_PATH="$HOME/your/path/to/pomodoro-app"  # Update this!
   BUILD_PATH="$HOME/Library/Developer/Xcode/DerivedData"

   if pgrep -x "Pomodoro" > /dev/null; then
       echo "✅ Pomodoro is already running"
       exit 0
   fi

   POMODORO_APP=$(find "$BUILD_PATH" -name "Pomodoro.app" -path "*/Debug/Pomodoro.app" 2>/dev/null | head -n 1)

   if [ -z "$POMODORO_APP" ]; then
       echo "🔨 Building..."
       cd "$APP_PATH" && xcodebuild -project Pomodoro.xcodeproj -scheme Pomodoro -configuration Debug build > /dev/null 2>&1
       POMODORO_APP=$(find "$BUILD_PATH" -name "Pomodoro.app" -path "*/Debug/Pomodoro.app" 2>/dev/null | head -n 1)
   fi

   if [ -n "$POMODORO_APP" ]; then
       echo "🍅 Launching Pomodoro..."
       open "$POMODORO_APP"
   fi
   EOF

   chmod +x ~/.local/bin/pomodoro

   # Add to PATH if needed
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

4. Launch from anywhere:
   ```bash
   pomodoro
   ```

The launcher will build the app if needed and launch it in your menu bar!

### Building from Source (Xcode)

1. Clone this repository:
   ```bash
   git clone https://github.com/selina-9911/pomodoro-app.git
   cd pomodoro-app
   ```

2. Open the project in Xcode:
   ```bash
   open Pomodoro.xcodeproj
   ```

3. Build and run:
   - Select the "Pomodoro" scheme
   - Press `Cmd+R` to build and run

## Usage

1. **Launch the app**: After building, the app will appear in your menu bar (top-right corner)

2. **Start a timer**: Click the menu bar icon and press the Play button

3. **Pause/Resume**: Click the Pause button to pause, Play to resume

4. **Reset**: Click the reset (circular arrow) button to reset the current session

5. **Skip**: Click the forward button to skip to the next session (Focus → Break or Break → Focus)

6. **Customize durations**: Click "Settings" to change focus and break durations

7. **Quit**: Click "Quit" to close the app

## Default Settings

- **Focus duration**: 60 minutes
- **Break duration**: 5 minutes

## Color Palette

The app uses a custom color palette that adapts to light/dark mode:
- Background: #F6F0D7 (soft cream) in light mode, #2a2a2a (dark gray) in dark mode
- Accent 1: #C5D89D (light sage)
- Accent 2: #9CAB84 (muted green)
- Accent 3: #89986D (dark olive)

## 🗺️ Roadmap

See [Issues](https://github.com/selina-9911/pomodoro-app/issues) for detailed feature requests and bug tracking.

### v1.2.0 (Critical Fixes)
- [ ] Fix timer accuracy ([#1](https://github.com/selina-9911/pomodoro-app/issues/1))
- [ ] Add accessibility labels ([#2](https://github.com/selina-9911/pomodoro-app/issues/2))
- [ ] Clean up menu bar display ([#6](https://github.com/selina-9911/pomodoro-app/issues/6))

### v1.3.0 (Feature Complete)
- [ ] Long break support ([#3](https://github.com/selina-9911/pomodoro-app/issues/3))
- [ ] Session counting & history ([#4](https://github.com/selina-9911/pomodoro-app/issues/4))
- [ ] Keyboard shortcuts ([#5](https://github.com/selina-9911/pomodoro-app/issues/5))
- [ ] Save state on quit ([#8](https://github.com/selina-9911/pomodoro-app/issues/8))

### v2.0.0 (Polish)
- [ ] Statistics dashboard ([#9](https://github.com/selina-9911/pomodoro-app/issues/9))
- [ ] Menu bar icon animation ([#10](https://github.com/selina-9911/pomodoro-app/issues/10))
- [ ] Visual feedback on buttons ([#7](https://github.com/selina-9911/pomodoro-app/issues/7))

## Project Structure

```
Pomodoro/
├── PomodoroApp.swift              # Main app entry point
├── Models/
│   ├── SessionType.swift          # Focus/Break session types
│   ├── Settings.swift             # User settings model
│   └── TimerViewModel.swift       # Timer logic and state
├── Views/
│   ├── MenuBarView.swift          # Main popover UI
│   └── SettingsView.swift         # Settings configuration
├── Managers/
│   ├── MenuBarManager.swift       # Menu bar integration
│   ├── NotificationManager.swift  # Desktop notifications
│   └── SoundPlayer.swift          # Audio playback
└── Assets.xcassets/               # App icons and assets
```

## License

Copyright © 2026 Pomodoro. All rights reserved.
