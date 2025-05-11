//
//  TextToSpeechView.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/11/25.
//

import SwiftUI

struct TextToSpeechView: View {
    @StateObject private var viewModel = TextToSpeechViewModel()

    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $viewModel.inputText)
                .border(Color.gray)
                .frame(height: 150)
                .padding()

            if viewModel.isSpeaking {
                Button("Stop Speaking") {
                    viewModel.stopSpeaking()
                }
                .foregroundColor(.red)
            } else {
                Button("Speak") {
                    viewModel.speak()
                }
                .foregroundColor(.blue)
            }

            if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}




#Preview {
    TextToSpeechView()
}
