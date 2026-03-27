//
//  SessionType.swift
//  Pomodoro
//
//  Created by Claude Code
//

import Foundation

/// Represents the type of Pomodoro session
enum SessionType: String, CaseIterable {
    case focus
    case `break`

    /// Display text for the session type
    var displayText: String {
        switch self {
        case .focus:
            return "Focus"
        case .break:
            return "Break"
        }
    }

    /// Default duration in seconds for each session type
    var defaultDuration: Int {
        switch self {
        case .focus:
            return 60 * 60 // 60 minutes
        case .break:
            return 5 * 60  // 5 minutes
        }
    }

    /// The next session type in the cycle
    var next: SessionType {
        switch self {
        case .focus:
            return .break
        case .break:
            return .focus
        }
    }
}
