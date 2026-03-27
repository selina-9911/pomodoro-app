# Quick Start Guide

## Building and Running

### Option 1: Using Xcode (Recommended)

1. Open the project:
   ```bash
   open Pomodoro.xcodeproj
   ```

2. In Xcode:
   - Select the "Pomodoro" scheme (top-left)
   - Press `Cmd+R` to build and run
   - The app will appear in your menu bar (top-right corner)

### Option 2: Command Line

```bash
# Build the project
xcodebuild -project Pomodoro.xcodeproj -scheme Pomodoro -configuration Debug

# Run the app
open ~/Library/Developer/Xcode/DerivedData/Pomodoro-*/Build/Products/Debug/Pomodoro.app
```

## First Use

1. **Grant Notification Permission**: When you first launch, the app will request permission to send notifications. Click "Allow" to receive desktop notifications when sessions complete.

2. **Menu Bar Icon**: Look for the timer icon (🍅 with time) in your menu bar (top-right corner of your screen).

3. **Start a Session**:
   - Click the menu bar icon
   - Click the Play button (⏵)
   - The timer will start counting down from 60:00

## Features

### Timer Controls

- **Play/Pause** (large button): Start or pause the timer
- **Reset** (circular arrow): Reset to the current session's duration
- **Skip** (forward arrow): Move to the next session (Focus → Break or Break → Focus)

### Sessions

- **Focus Session** (🍅): Default 60 minutes
- **Break Session** (☕️): Default 5 minutes

The app automatically transitions between focus and break sessions:
- Focus → Notification + Sound → Break
- Break → Notification + Sound → Focus

### Settings

Click "Settings" in the popover to customize:
- Focus duration (1-120 minutes)
- Break duration (1-60 minutes)

Settings are saved automatically and persist after app restart.

### Quitting

Click "Quit" in the popover to close the app.

## Troubleshooting

### App doesn't appear in menu bar

- Check that the app is running (look in Activity Monitor for "Pomodoro")
- The app intentionally does NOT appear in the dock
- Look for the timer icon in the top-right corner of your screen

### Notifications not appearing

- Open System Settings → Notifications
- Find "Pomodoro" in the list
- Enable "Allow Notifications"

### Sound not playing

- The app uses a system beep by default (no sound file included)
- To use a custom sound, add `session-end.mp3` to the Pomodoro/Resources folder

### Timer not counting down

- Make sure you clicked the Play button (not just opened the popover)
- The menu bar should update every second

### Settings not saving

- Make sure you click "Save" in the settings window
- Settings are stored in UserDefaults and persist across app restarts

## Development Tips

### Debugging

To see debug logs while developing:

1. Run the app from Xcode (Cmd+R)
2. Open the Debug Console (Cmd+Shift+C)
3. Logs will appear in the console

### Clean Build

If you encounter build issues:

```bash
xcodebuild clean -project Pomodoro.xcodeproj -scheme Pomodoro
```

Then rebuild the project.

### Modifying Timer Durations

Default durations are set in `SessionType.swift`:
- Focus: 60 minutes
- Break: 5 minutes

You can change these defaults or use the Settings UI to customize per user.

## Next Steps

- Customize the color palette in `MenuBarView.swift`
- Add a custom sound file to `Pomodoro/Resources/`
- Modify timer durations in Settings
- Export the app to share with others

For more details, see:
- `README.md` - General project information
- `CLAUDE.md` - Developer guide and architecture
