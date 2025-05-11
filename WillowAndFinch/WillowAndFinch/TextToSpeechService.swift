//
//  TextToSpeechService.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import AVFoundation

class TextToSpeechService: NSObject, TextToSpeechServiceProtocol, AVSpeechSynthesizerDelegate {
    private let synthesizer: AVSpeechSynthesizer
    private var currentUtterance: AVSpeechUtterance?
    private var onFinishSpeaking: (() -> Void)?

    override init() {
        self.synthesizer = AVSpeechSynthesizer()
        super.init()
        self.synthesizer.delegate = self
    }

    func speak(text: String, withVoice voiceIdentifier: String? = nil, completion: @escaping () -> Void) throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .voicePrompt, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionSetupFailed
        }

        let utterance = AVSpeechUtterance(string: text)
        if let voiceId = voiceIdentifier, let selectedVoice = AVSpeechSynthesisVoice(identifier: voiceId) {
            utterance.voice = selectedVoice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: Locale.current.language.languageCode?.identifier ?? "en-US")
        }

        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        self.currentUtterance = utterance
        self.onFinishSpeaking = {
            completion()
            try? self.restoreAudioSession()
        }

        synthesizer.speak(utterance)
    }

    func stopSpeaking() throws {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            currentUtterance = nil
            try restoreAudioSession()
        }
    }

    private func restoreAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionDeactivationFailed(error.localizedDescription)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onFinishSpeaking?()
        onFinishSpeaking = nil
    }
}


