//
//  SettingsView.swift
//  Pomodoro
//
//  Created by Claude Code
//

import SwiftUI

/// Settings configuration view
struct SettingsView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    @Environment(\.dismiss) var dismiss

    @State private var focusDuration: Int
    @State private var breakDuration: Int

    // Color palette
    private let backgroundColor = Color(hex: "F6F0D7")
    private let accentColor2 = Color(hex: "9CAB84")

    init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
        let settings = Settings.load()
        _focusDuration = State(initialValue: settings.focusDuration)
        _breakDuration = State(initialValue: settings.breakDuration)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.system(size: 24, weight: .bold))
                .padding(.top)

            Form {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Focus Duration (minutes)")
                        .font(.headline)

                    HStack {
                        TextField("Minutes", value: $focusDuration, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 100)

                        Stepper("", value: $focusDuration, in: 1...120)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Break Duration (minutes)")
                        .font(.headline)

                    HStack {
                        TextField("Minutes", value: $breakDuration, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 100)

                        Stepper("", value: $breakDuration, in: 1...60)
                    }
                }
            }
            .padding()

            // Action buttons
            HStack(spacing: 16) {
                Button("Cancel") {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)

                Button("Save") {
                    saveSettings()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .tint(accentColor2)
            }
            .padding(.bottom)
        }
        .frame(width: 400, height: 300)
        .background(backgroundColor)
    }

    private func saveSettings() {
        let settings = Settings(
            focusDuration: focusDuration,
            breakDuration: breakDuration
        )
        settings.save()
        timerViewModel.reloadSettings()
        dismiss()
    }
}
