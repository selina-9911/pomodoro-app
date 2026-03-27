//
//  AppTheme.swift
//  Pomodoro
//
//  Centralized theme management for light and dark modes
//

import SwiftUI

struct AppTheme {
    let backgroundColor: Color
    let accentColor1: Color
    let accentColor2: Color
    let accentColor3: Color

    static func current(for colorScheme: ColorScheme) -> AppTheme {
        colorScheme == .dark ? .dark : .light
    }

    static let light = AppTheme(
        backgroundColor: Color(hex: "F6F0D7"),
        accentColor1: Color(hex: "C5D89D"),
        accentColor2: Color(hex: "9CAB84"),
        accentColor3: Color(hex: "89986D")
    )

    static let dark = AppTheme(
        backgroundColor: Color(hex: "2a2a2a"),
        accentColor1: Color(hex: "8fb380"),
        accentColor2: Color(hex: "7a9c6f"),
        accentColor3: Color(hex: "a8c99f")
    )
}
