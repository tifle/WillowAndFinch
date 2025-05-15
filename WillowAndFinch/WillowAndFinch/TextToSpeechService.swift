//
//  TextToSpeechService.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import AVFoundation

// Service class for handling text-to-speech functionality
class TextToSpeechService: NSObject, TextToSpeechServiceProtocol, AVSpeechSynthesizerDelegate {
    // properties
    private let synthesizer: AVSpeechSynthesizer
    private var currentUtterance: AVSpeechUtterance?
    private var onFinishSpeaking: (() -> Void)?

    // initializer
    override init() {
        self.synthesizer = AVSpeechSynthesizer()
        super.init()
        self.synthesizer.delegate = self
    }

    // public methods
    func speak(text: String, withVoice voiceIdentifier: String? = nil, completion: @escaping () -> Void) throws {
        let audioSession = AVAudioSession.sharedInstance()
        do { // audio session for playback
            try audioSession.setCategory(.playback, mode: .voicePrompt, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionSetupFailed
        }
        // speech text
        let utterance = AVSpeechUtterance(string: text)
        if let voiceId = voiceIdentifier, let selectedVoice = AVSpeechSynthesisVoice(identifier: voiceId) {
            utterance.voice = selectedVoice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: Locale.current.language.languageCode?.identifier ?? "en-US")
        }
        // stop immediately if currently speaking
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        self.currentUtterance = utterance
        self.onFinishSpeaking = {
            completion()
            // restore audio session
            try? self.restoreAudioSession()
        }
        // begin speaking
        synthesizer.speak(utterance)
    }
    // stop current speech
    func stopSpeaking() throws {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            currentUtterance = nil
            try restoreAudioSession()
        }
    }
    // deactivate audio session
    private func restoreAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionDeactivationFailed(error.localizedDescription)
        }
    }
    // run completion handler
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onFinishSpeaking?()
        onFinishSpeaking = nil
    }
}


