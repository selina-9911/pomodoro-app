//
//  MenuBarManager.swift
//  Pomodoro
//
//  Created by Claude Code
//

import SwiftUI
import AppKit

/// Manages the menu bar status item and popover
class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var timerViewModel: TimerViewModel?

    func setupMenuBar(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel

        // Create status item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            // Use SF Symbol for timer icon
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Pomodoro Timer")
            button.action = #selector(togglePopover)
            button.target = self
        }

        // Create popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 280, height: 320)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(
            rootView: MenuBarView(timerViewModel: timerViewModel)
        )
        self.popover = popover

        // Update menu bar text with timer
        updateMenuBarTitle()
    }

    /// Toggle popover visibility
    @objc private func togglePopover() {
        guard let button = statusItem?.button else { return }

        if let popover = popover {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

    /// Show the popover (for programmatic display, e.g., on timer completion)
    func showPopover() {
        guard let button = statusItem?.button,
              let popover = popover,
              !popover.isShown else { return }

        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }

    /// Update the menu bar title with the current timer
    func updateMenuBarTitle() {
        guard let timerViewModel = timerViewModel else { return }

        let timeString = timerViewModel.formattedTime
        let sessionIcon = timerViewModel.sessionType == .focus ? "🍅" : "☕️"

        statusItem?.button?.title = " \(sessionIcon) \(timeString)"
    }
}
