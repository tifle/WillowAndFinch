//
//  MoreInfoView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

// Color themes
struct WFColors {
    static let cafeBrown = Color(red: 0.42, green: 0.35, blue: 0.28)
    static let sageGreen = Color(red: 0.53, green: 0.57, blue: 0.40)
    static let latteMilk = Color(red: 1, green: 0.96, blue: 0.91)
}

struct MoreInfoView: View {
    // TTS Model
    @StateObject private var viewModel = TextToSpeechViewModel()
    
    // Track speaking states for each section
    @State private var isSpeakingHelp = false
    @State private var isSpeakingWhatIs = false
    @State private var isSpeakingGettingStarted = false
    @State private var isSpeakingFAQ = false
    @State private var isSpeakingContact = false
    
    // environment for color scheme
    @Environment(\.colorScheme) var colorScheme
    
    // enable color scheme based on the dark/light mode
    var backgroundColor: Color {
        colorScheme == .dark ? WFColors.cafeBrown : WFColors.latteMilk
    }
    // enable color scheme based on the dark/light mode
    var textColor: Color {
        colorScheme == .dark ? WFColors.latteMilk : WFColors.cafeBrown
    }
    
    var body: some View {
        ZStack {
            // Background color for entire content area
            VStack(spacing: 0) {
                Color.sageGreen.frame(height: 300)
                Color("BackgroundColor")
            }
            .edgesIgnoringSafeArea(.top)
            // Scroll View for the user to view the more information
            ScrollView {
                // vertical stack
                VStack(alignment: .leading, spacing: 20) {
                    // horizontal stack
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        // title
                        Text("More Information")
                            .font(.custom("Georgia", size: 30))
                            .bold()
                            .foregroundColor(Color("TextColor"))

                        // TTS for the Title
                        TTSButtonSection(for: "Help & Documentation", viewModel: viewModel, isSpeaking: $isSpeakingHelp)
                            .foregroundColor(textColor)
                    }
                    // group the text w/ the TTS
                    Group {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("🌿 What is Willow & Finch?")
                                .font(.custom("Georgia", size: 20))
                                .bold()
                                .foregroundColor(textColor)
                            // TTS for What is...
                            TTSButtonSection(
                                for: "What is Willow & Finch? Willow & Finch helps you store and read your books. This guide explains how to get started and make the most of your experience.",
                                viewModel: viewModel,
                                isSpeaking: $isSpeakingWhatIs
                            )
                        }
                        // show the text
                        Text("Willow & Finch helps you store and read your books. This guide explains how to get started and make the most of your experience.")
                            .foregroundColor(textColor)
                            .font(.custom("Avenir", size: 16))
                        
                        // group the text w/ the TTS
                        Group {
                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text("🛠️ Getting Started")
                                    .font(.custom("Georgia", size: 20))
                                    .bold()
                                    .foregroundColor(textColor)
                                // TTS for Getting Started
                                TTSButtonSection(for: "Getting Started 1. Search for your book via search bar 2. Utilize the recommendation page 3. Check your saved books in 'Finch Nest'", viewModel: viewModel, isSpeaking: $isSpeakingGettingStarted)
                                    .foregroundColor(textColor)
                            }
                            // show the text
                            Text("""
                                1. Search for your book via search bar
                                2. Utilize the recommendation page
                                3. Check your saved books in "Finch Nest"
                                """)
                                .foregroundColor(textColor)
                                .font(.custom("Avenir", size: 16))

                        }
                        // group the text w/ the TTS
                        Group {
                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text("❓ Frequently Asked Questions")
                                    .font(.custom("Georgia", size: 20))
                                    .bold()
                                    .foregroundColor(textColor)
                                // TTS for FAQ
                                TTSButtonSection(for: "Frequently Asked Questions Q:How do I get a book recommended? A: Recommendation Page -> Get Started Q: How to save a book for later? A: Click the save button", viewModel: viewModel, isSpeaking: $isSpeakingFAQ)
                                    .foregroundColor(textColor)
                            }
                            // show text
                            Text("**Q:** How do I get a book recommended?\n**A:** Recommendation Page -> Get Started\n\n**Q:** How to save a book for later?\n**A:** Click the save button")
                                .font(.custom("Avenir", size: 16))
                                .foregroundColor(textColor)
                        }
                        // group the text w/ the TTS
                        Group {
                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text("📞 Contact & Support")
                                    .font(.custom("Georgia", size: 20))
                                    .bold()
                                    .foregroundColor(textColor)
                                // TTS for Contact
                                TTSButtonSection(for: "Contact & Support Need more help? Email us at support@willowandfinch.app (Email is not active)", viewModel: viewModel, isSpeaking: $isSpeakingContact)
                                    .foregroundColor(textColor)
                            }
                            // show text
                            Text("Need more help? Email us at support@willowandfinch.app (Email is not active)")
                                .font(.custom("Avenir", size: 16))
                                .foregroundColor(textColor)
                        }

                    }
                    .padding()
                }
                .padding()
                .background(Color("BackgroundColor").ignoresSafeArea(edges: .top))
                .background(Color("TabColor"))
            }
        }
    }
    // code for the TTS button (speaker and slash speaker)
    @MainActor
    func TTSButtonSection(for text: String, viewModel: TextToSpeechViewModel, isSpeaking: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Button {
                    // check if it's speaking
                    if viewModel.isSpeaking {
                        // stop speaking
                        viewModel.stopSpeaking()
                        isSpeaking.wrappedValue = false

                        // Reset all speaking states
                        isSpeakingHelp = false
                        isSpeakingWhatIs = false
                        isSpeakingGettingStarted = false
                        isSpeakingFAQ = false
                        isSpeakingContact = false
                    } else {
                        viewModel.inputText = text
                        viewModel.speak()
                        isSpeaking.wrappedValue = true
                    }
                } label: { // image of the button (speaker or not speaking)
                    Image(systemName: isSpeaking.wrappedValue ? "speaker.slash.fill" : "speaker.wave.2.fill")
                        .font(.headline)
                        .foregroundColor(isSpeaking.wrappedValue ? .red : .blue)
                }
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    MoreInfoView()
        .environmentObject(FinchNestViewModel())
}
