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

    // Color palette
    private let backgroundColor = Color(hex: "F6F0D7")
    private let accentColor1 = Color(hex: "C5D89D")
    private let accentColor2 = Color(hex: "9CAB84")
    private let accentColor3 = Color(hex: "89986D")

    var body: some View {
        VStack(spacing: 20) {
            // Session type indicator
            Text(timerViewModel.sessionType.displayText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(timerViewModel.sessionType == .focus ? accentColor3 : accentColor2)

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
                        .background(accentColor2)
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
                        .background(accentColor1)
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
                        .background(accentColor1)
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
                        .foregroundColor(accentColor3)
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
        .background(backgroundColor)
        .sheet(isPresented: $showingSettings) {
            SettingsView(timerViewModel: timerViewModel)
        }
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
