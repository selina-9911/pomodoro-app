# Pomodoro - macOS Menu Bar Timer

A minimalist Pomodoro timer that lives in your macOS menu bar. Built with SwiftUI and AppKit.

## Features

- Lives in the macOS menu bar (status bar)
- Customizable focus and break durations
- Desktop notifications when sessions complete
- Sound notifications
- Simple, clean interface with a custom color palette
- Settings persistence using UserDefaults

## Requirements

- macOS 13.0 or later
- Xcode 15.0 or later

## Installation

### Building from Source

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd pomodoro
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

The app uses a custom color palette:
- Background: #F6F0D7 (soft cream)
- Accent 1: #C5D89D (light sage)
- Accent 2: #9CAB84 (muted green)
- Accent 3: #89986D (dark olive)

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
