//
//  SpeechService.swift
//  Orbit
//
//  Created by Danah AlQahtani on 10/06/1447 AH.
//

import Foundation
import AVFoundation

final class SpeechService: NSObject, AVSpeechSynthesizerDelegate, @unchecked Sendable {
    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Start speaking some text using Apple's built-in voice
    func speak(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // If already speaking, stop first
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: trimmed)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }

    /// Stop speaking immediately
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    /// Expose whether the synthesizer is currently speaking
    var isSpeaking: Bool {
        synthesizer.isSpeaking
    }
}
