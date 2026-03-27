//
//  NotificationManager.swift
//  Pomodoro
//
//  Created by Claude Code
//

import Foundation
import UserNotifications

/// Manages desktop notifications for the Pomodoro app
class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    /// Request notification permissions from the user
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }

    /// Send a notification with the given title and body
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // Deliver immediately
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to send notification: \(error.localizedDescription)")
            }
        }
    }
}
