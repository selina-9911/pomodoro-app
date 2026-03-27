//
//  MenuBarView.swift
//  Pomodoro
//
//  Created by Claude Code
//

import SwiftUI

/// Main menu bar popover content view
struct MenuBarView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    @State private var showingSettings = false
    @Environment(\.colorScheme) var colorScheme

    private var theme: AppTheme {
        AppTheme.current(for: colorScheme)
    }

    var body: some View {
        VStack(spacing: 20) {
            // Session type indicator
            Text(timerViewModel.sessionType.displayText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(timerViewModel.sessionType == .focus ? theme.accentColor3 : theme.accentColor2)

            // Timer display
            Text(timerViewModel.formattedTime)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(.primary)

            // Control buttons
            HStack(spacing: 16) {
                // Start/Pause button
                Button(action: {
                    if timerViewModel.isRunning {
                        timerViewModel.pause()
                    } else {
                        timerViewModel.start()
                    }
                }) {
                    Image(systemName: timerViewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(theme.accentColor2)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                // Reset button
                Button(action: {
                    timerViewModel.reset()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(theme.accentColor1)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                // Skip button
                Button(action: {
                    timerViewModel.skip()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(theme.accentColor1)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }

            Divider()

            // Settings and Quit buttons
            HStack {
                Button(action: {
                    showingSettings = true
                }) {
                    Label("Settings", systemImage: "gearshape")
                        .font(.system(size: 14))
                        .foregroundColor(theme.accentColor3)
                }
                .buttonStyle(.plain)

                Spacer()

                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Label("Quit", systemImage: "xmark.circle")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(theme.backgroundColor)
        .sheet(isPresented: $showingSettings) {
            SettingsView(timerViewModel: timerViewModel)
        }
    }
}
