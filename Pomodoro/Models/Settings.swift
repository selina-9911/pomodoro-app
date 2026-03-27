//
//  Settings.swift
//  Pomodoro
//
//  Created by Claude Code
//

import Foundation

/// User settings for Pomodoro timer durations
struct Settings: Codable {
    var focusDuration: Int // in minutes
    var breakDuration: Int // in minutes

    /// Default settings
    static let `default` = Settings(
        focusDuration: 60,
        breakDuration: 5
    )

    private static let settingsKey = "PomodoroSettings"

    /// Save settings to UserDefaults
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Settings.settingsKey)
        }
    }

    /// Load settings from UserDefaults
    static func load() -> Settings {
        guard let data = UserDefaults.standard.data(forKey: settingsKey),
              let settings = try? JSONDecoder().decode(Settings.self, from: data) else {
            return .default
        }
        return settings
    }
}
