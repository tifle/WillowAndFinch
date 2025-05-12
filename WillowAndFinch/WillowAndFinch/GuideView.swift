//
//  GuideView.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/12/25.
//

import SwiftUI

struct GuideView: View {
    @Binding var showGuide: Bool

    var body: some View {
        VStack(spacing: 24) {
            Text("Customize Your Reading Experience")
                .font(.title)
                .bold()

            VStack(alignment: .leading, spacing: 16) {
                Label("Tap the ✍️ icon to change font, size, and toggle dark mode.", systemImage: "textformat.size")
                Label("Use the speaker icon to toggle read-aloud.", systemImage: "speaker.wave.2.fill")
                Label("Scroll to read and track your progress at the bottom.", systemImage: "scroll")
            }
            .font(.body)
            .padding(.horizontal)

            Button("Got it! Let's Read") {
                showGuide = false
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(12)

            Button("Skip Tutorial") {
                showGuide = false
            }
            .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}
