//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Claude Code
//

import SwiftUI
import Combine

@main
struct PomodoroApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // Empty scene - we're using menu bar only
        WindowGroup {
            EmptyView()
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 0, height: 0)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuBarManager: MenuBarManager?
    private var timerViewModel: TimerViewModel?
    private var timerCancellable: AnyCancellable?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Request notification permissions
        NotificationManager.shared.requestAuthorization()

        // Setup menu bar first (needed for TimerViewModel)
        menuBarManager = MenuBarManager()

        // Initialize view model with menuBarManager reference
        timerViewModel = TimerViewModel(
            notificationManager: NotificationManager.shared,
            soundPlayer: SoundPlayer.shared,
            menuBarManager: menuBarManager
        )

        // Complete menu bar setup with timerViewModel
        if let timerViewModel = timerViewModel {
            menuBarManager?.setupMenuBar(timerViewModel: timerViewModel)

            // Subscribe to timer updates to refresh menu bar
            timerCancellable = timerViewModel.objectWillChange.sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.menuBarManager?.updateMenuBarTitle()
                }
            }
        }

        // Hide dock icon (menu bar app only)
        NSApp.setActivationPolicy(.accessory)
    }
}
