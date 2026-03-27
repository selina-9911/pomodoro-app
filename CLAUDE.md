# Pomodoro macOS Menu Bar App - Developer Guide

## Project Overview

This is a native macOS menu bar application built with SwiftUI and AppKit that implements a Pomodoro timer. The app provides a simple, distraction-free way to manage focus sessions and breaks directly from the menu bar.

## Architecture

### Technology Stack

- **SwiftUI**: UI components and reactive state management
- **AppKit**: Menu bar integration (`NSStatusBar`, `NSMenu`, `NSPopover`)
- **UserNotifications**: Desktop notification delivery
- **AVFoundation**: Audio playback for session completion sounds
- **Combine**: Reactive timer management and state updates
- **UserDefaults**: Settings persistence

### Key Design Decisions

1. **Menu Bar Only**: The app runs as a menu bar-only application (`LSUIElement = true` in Info.plist), with no dock icon
2. **Popover Interface**: Uses `NSPopover` to display SwiftUI content when the menu bar icon is clicked
3. **MVVM Pattern**: Clean separation between UI (Views), business logic (ViewModels), and services (Managers)
4. **Reactive Updates**: Combine publishers automatically update the menu bar title when timer state changes

## Project Structure

```
Pomodoro/
├── PomodoroApp.swift              # App lifecycle, AppDelegate
├── Models/
│   ├── SessionType.swift          # Enum for Focus/Break sessions
│   ├── Settings.swift             # Codable settings model with persistence
│   └── TimerViewModel.swift       # ObservableObject for timer state
├── Views/
│   ├── MenuBarView.swift          # Main popover UI with controls
│   └── SettingsView.swift         # Settings configuration sheet
├── Managers/
│   ├── MenuBarManager.swift       # NSStatusBar and NSPopover management
│   ├── NotificationManager.swift  # UNUserNotificationCenter wrapper
│   └── SoundPlayer.swift          # AVAudioPlayer for sound effects
├── Resources/
│   └── doro.aiff                  # "Tuturu" notification sound (345KB, 2 seconds)
└── Assets.xcassets/               # App icons and menu bar icon
```

## Recent Updates (March 2026)

### New Features Added

1. **Custom "Tuturu" Sound**: Replaced system beep with a cute 2-second "Tuturu" sound effect (`doro.aiff`)
2. **Auto-Show Popover**: Popover automatically appears when timer completes (in addition to sound and notification)
3. **MenuBarManager Integration**: TimerViewModel now holds a weak reference to MenuBarManager to trigger popover display

### Implementation Details

- **Sound File**: `Pomodoro/Resources/doro.aiff` (AIFF format, 345KB, must be added to Xcode project's "Copy Bundle Resources")
- **Popover Display**: `MenuBarManager.showPopover()` is called in `TimerViewModel.completeSession()` via `DispatchQueue.main.async`
- **Retain Cycle Prevention**: MenuBarManager is stored as `weak var` in TimerViewModel
- **Initialization Order**: AppDelegate creates MenuBarManager before TimerViewModel to pass the reference

## Core Components

### TimerViewModel

**Responsibilities:**
- Maintain timer state (timeRemaining, sessionType, isRunning, isPaused)
- Handle timer countdown using Combine's `Timer.publish()`
- Manage session transitions (Focus → Break → Focus)
- Trigger notifications and sounds on session completion
- Load/reload user settings

**Key Methods:**
- `start()`: Start or resume the timer
- `pause()`: Pause the timer
- `reset()`: Reset to current session's duration
- `skip()`: Move to the next session type
- `reloadSettings()`: Refresh settings from UserDefaults

### MenuBarManager

**Responsibilities:**
- Create and configure `NSStatusItem` in the system status bar
- Set up the popover with SwiftUI content
- Update menu bar title with current timer and session emoji
- Handle popover show/hide on status item click

**Key Methods:**
- `setupMenuBar(timerViewModel:)`: Initialize status bar and popover
- `togglePopover()`: Show or hide the popover (private, user-triggered)
- `showPopover()`: Programmatically show popover (public, for timer completion alerts)
- `updateMenuBarTitle()`: Refresh the status bar text

### NotificationManager

**Responsibilities:**
- Request notification permissions on app launch
- Send desktop notifications using `UNUserNotificationCenter`

**Key Methods:**
- `requestAuthorization()`: Request user permission for notifications
- `sendNotification(title:body:)`: Deliver a notification

### SoundPlayer

**Responsibilities:**
- Play audio when sessions complete
- Fallback to system beep if sound file is missing

**Key Methods:**
- `play()`: Play session completion sound

## Building and Running

### Quick Launch (Recommended)

A command-line launcher is available at `~/.local/bin/pomodoro`:

```bash
# Launch the app (builds if needed, checks if already running)
pomodoro
```

The launcher script:
- Auto-builds the app if not already built
- Prevents duplicate instances
- Provides helpful error messages
- Located at: `~/.local/bin/pomodoro`

### Command Line Build

```bash
# Navigate to project directory
cd /path/to/pomodoro

# Build the project
xcodebuild -project Pomodoro.xcodeproj -scheme Pomodoro -configuration Debug

# Run the app
open ~/Library/Developer/Xcode/DerivedData/Pomodoro-*/Build/Products/Debug/Pomodoro.app
```

### Xcode Build

1. Open `Pomodoro.xcodeproj` in Xcode
2. Select the "Pomodoro" scheme
3. Press `Cmd+R` to build and run
4. The app will appear in the menu bar

### Build Configuration

- **Minimum macOS Version**: 13.0
- **Swift Version**: 5.0
- **Bundle Identifier**: com.pomodoro.app
- **Entitlements**: App Sandbox enabled with user-selected file read access

## Testing

### Manual Testing Checklist

1. **App Launch**
   - App icon appears in menu bar
   - No dock icon appears
   - Default timer shows 60:00

2. **Timer Controls**
   - Start: Timer counts down by 1 second per tick
   - Pause: Timer stops, can be resumed
   - Reset: Timer returns to session duration
   - Skip: Moves to next session type

3. **Session Transitions**
   - Focus (60 min) → Notification → Break (5 min)
   - Break (5 min) → Notification → Focus (60 min)
   - Timer auto-resets after completion

4. **Notifications**
   - Desktop notification appears on session completion
   - Sound plays on session completion
   - Notification permission requested on first launch

5. **Settings**
   - Settings view opens in sheet
   - Can modify focus and break durations
   - Settings persist after app restart
   - Timer resets to new duration after save

6. **Menu Bar Updates**
   - Menu bar title updates every second
   - Session emoji changes (🍅 for focus, ☕️ for break)
   - Time displays correctly (MM:SS format)

### Debug Tips

- Check Console.app for debug logs
- Verify notification permissions: System Settings → Notifications → Pomodoro
- Check UserDefaults: `defaults read com.pomodoro.app`

## Key Files

### Critical Files (Do Not Delete)

- `PomodoroApp.swift`: App entry point and lifecycle
- `TimerViewModel.swift`: Core timer logic
- `MenuBarManager.swift`: Menu bar integration
- `Info.plist`: App configuration (LSUIElement)
- `Pomodoro.entitlements`: Sandbox permissions
- `project.pbxproj`: Xcode project configuration

### Configuration Files

- **Info.plist**: Contains `LSUIElement = true` to hide dock icon
- **Pomodoro.entitlements**: Enables App Sandbox
- **project.pbxproj**: Build settings and file references

## Common Issues and Solutions

### Issue: App doesn't appear in menu bar
**Solution**: Check that `LSUIElement` is set to `true` in Info.plist and that `NSApp.setActivationPolicy(.accessory)` is called in AppDelegate.

### Issue: Notifications not showing
**Solution**: Check notification permissions in System Settings. The app requests permissions on launch, but users can deny them.

### Issue: Sound not playing or wrong sound
**Solution**: Verify `doro.aiff` is included in the Xcode project and added to the "Copy Bundle Resources" build phase. Check that:
1. The file exists at `Pomodoro/Resources/doro.aiff`
2. It's listed in the Xcode project navigator under Resources folder
3. In Build Phases → "Copy Bundle Resources", `doro.aiff` is present
4. The built app contains it at: `Pomodoro.app/Contents/Resources/doro.aiff`

The app falls back to system beep if the file is missing. To verify the file is included after building:
```bash
ls ~/Library/Developer/Xcode/DerivedData/Pomodoro-*/Build/Products/Debug/Pomodoro.app/Contents/Resources/doro.aiff
```

### Issue: Settings not persisting
**Solution**: Check that the bundle identifier is correct and UserDefaults is accessible. Verify settings are saved with `settings.save()` before dismissing the settings view.

## Future Enhancements (Out of Scope)

- Statistics and history tracking
- Multiple timer profiles
- iCloud sync
- Menu bar icon animations
- Keyboard shortcuts
- Multiple break types (short/long)
- Daily goal tracking

## Development Patterns

### SwiftUI + AppKit Integration

This project demonstrates how to integrate SwiftUI with AppKit for menu bar applications:

1. Use `NSHostingController` to embed SwiftUI views in `NSPopover`
2. Use `@NSApplicationDelegateAdaptor` to access AppDelegate lifecycle
3. Subscribe to `ObservableObject.objectWillChange` to update AppKit UI

### Reactive State Management

Timer state is managed reactively using Combine:

```swift
Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
    .sink { [weak self] _ in
        self?.tick()
    }
```

### Settings Persistence

Settings are persisted using UserDefaults with Codable:

```swift
let encoded = try JSONEncoder().encode(settings)
UserDefaults.standard.set(encoded, forKey: "PomodoroSettings")
```

## Contributing

When making changes:

1. Follow Swift API design guidelines
2. Keep the UI minimal and focused
3. Test notification permissions and sound playback
4. Verify settings persistence across app restarts
5. Update this documentation for architectural changes

## Build Commands Summary

```bash
# Build
xcodebuild -project Pomodoro.xcodeproj -scheme Pomodoro

# Clean
xcodebuild clean -project Pomodoro.xcodeproj -scheme Pomodoro

# Archive
xcodebuild archive -project Pomodoro.xcodeproj -scheme Pomodoro
```
