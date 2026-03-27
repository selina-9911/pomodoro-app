//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by Claude Code
//

import Foundation
import Combine

/// View model managing the Pomodoro timer state and business logic
class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var sessionType: SessionType = .focus
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false

    private var settings: Settings = .default
    private var timerCancellable: AnyCancellable?
    private let notificationManager: NotificationManager
    private let soundPlayer: SoundPlayer
    private weak var menuBarManager: MenuBarManager?

    init(notificationManager: NotificationManager, soundPlayer: SoundPlayer, menuBarManager: MenuBarManager? = nil) {
        self.notificationManager = notificationManager
        self.soundPlayer = soundPlayer
        self.menuBarManager = menuBarManager
        self.settings = Settings.load()
        self.timeRemaining = settings.focusDuration * 60
    }

    /// Formatted time string (MM:SS)
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    /// Start or resume the timer
    func start() {
        guard !isRunning else { return }

        isRunning = true
        isPaused = false

        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    /// Pause the timer
    func pause() {
        guard isRunning else { return }

        isRunning = false
        isPaused = true
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    /// Reset the timer to the current session's duration
    func reset() {
        pause()
        isPaused = false
        let duration = sessionType == .focus ? settings.focusDuration : settings.breakDuration
        timeRemaining = duration * 60
    }

    /// Skip to the next session
    func skip() {
        pause()
        isPaused = false
        sessionType = sessionType.next
        let duration = sessionType == .focus ? settings.focusDuration : settings.breakDuration
        timeRemaining = duration * 60
    }

    /// Reload settings from UserDefaults
    func reloadSettings() {
        settings = Settings.load()
        reset()
    }

    /// Handle timer tick
    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            // Session complete
            completeSession()
        }
    }

    /// Handle session completion
    private func completeSession() {
        pause()

        // Play sound and send notification
        soundPlayer.play()

        let message = sessionType == .focus ? "Focus session complete!" : "Break complete!"
        notificationManager.sendNotification(title: "Pomodoro", body: message)

        // Show popover to alert user visually
        DispatchQueue.main.async { [weak self] in
            self?.menuBarManager?.showPopover()
        }

        // Move to next session
        sessionType = sessionType.next
        let duration = sessionType == .focus ? settings.focusDuration : settings.breakDuration
        timeRemaining = duration * 60
    }
}
