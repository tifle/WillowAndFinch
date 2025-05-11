//
//  TextToSpeechServiceProtocol.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import Foundation

protocol TextToSpeechServiceProtocol {
    func speak(text: String, withVoice voiceIdentifier: String?, completion: @escaping () -> Void) throws
    func stopSpeaking() throws
}
