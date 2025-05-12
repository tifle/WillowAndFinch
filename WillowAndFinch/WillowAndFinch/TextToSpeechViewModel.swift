//
//  TextToSpeechViewModel.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import Foundation

@MainActor
class TextToSpeechViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var isSpeaking: Bool = false
    @Published var errorMessage: String?

    private let textToSpeechService: TextToSpeechServiceProtocol

    init(service: TextToSpeechServiceProtocol = TextToSpeechService()) {
        self.textToSpeechService = service
    }

    func speak() {
        guard !inputText.isEmpty else { return }
        isSpeaking = true

        do {
            try textToSpeechService.speak(text: inputText, withVoice: "com.apple.ttsbundle.siri_male_en-US_compact") {
                self.isSpeaking = false
            }
        } catch {
            errorMessage = error.localizedDescription
            isSpeaking = false
        }
    }

    func stopSpeaking() {
        do {
            try textToSpeechService.stopSpeaking()
            isSpeaking = false
        } catch {
            errorMessage = error.localizedDescription
            isSpeaking = false
        }
    }


}
