//
//  TextToSpeechError.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import Foundation

enum TextToSpeechError: Error {
    case audioSessionSetupFailed
    case audioSessionDeactivationFailed(String)
}
