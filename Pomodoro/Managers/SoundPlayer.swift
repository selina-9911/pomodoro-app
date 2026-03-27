//
//  SoundPlayer.swift
//  Pomodoro
//
//  Created by Claude Code
//

import Foundation
import AVFoundation
import AppKit

/// Manages audio playback for session completion sounds
class SoundPlayer {
    static let shared = SoundPlayer()

    private var audioPlayer: AVAudioPlayer?

    private init() {}

    /// Play the session completion sound
    func play() {
        // Try to find the sound file in the bundle
        guard let soundURL = Bundle.main.url(forResource: "doro", withExtension: "aiff") else {
            // If no sound file found, play system beep as fallback
            NSSound.beep()
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
            NSSound.beep()
        }
    }
}
