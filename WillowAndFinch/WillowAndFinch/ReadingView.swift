//
//  ReadingView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct ReadingView: View {
    // TTS Model
    @StateObject private var viewModelReading = TextToSpeechViewModel()
    
    @State private var fontName: String = "Avenir"
    @State private var fontSize: CGFloat = 16
    @State private var useDarkBackground: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 1 // Prevent divide by zero
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var isDraggingProgress: Bool = false

    // Guide state
//    @AppStorage("hasSeenGuide") private var hasSeenGuide = false
    @State private var showGuide = false
    @State private var guideStep = 0
    @State private var dontShow = false

    // Track speaking state
    @State private var isSpeakingText = false

    let title = "The Yellow Wallpaper"
    let author = "By Charlotte Perkins Gilman"
    
    let textContent = """
    It is very seldom that mere ordinary people like John and myself secure ancestral halls for the summer.
    ...
    That spoils my ghostliness, I am afraid; but I don't care—there is something strange about the house—I can feel it.
    """

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Settings Bar
                HStack {
                    Menu {
                        Picker("Font", selection: $fontName) {
                            Text("Avenir").tag("Avenir")
                            Text("Georgia").tag("Georgia")
                            Text("Courier").tag("Courier")
                            Text("Times").tag("Times")
                        }
                        VStack {
                            Text("Font Size: \(Int(fontSize))")
                            Slider(value: $fontSize, in: 12...30)
                        }
                        Toggle("Dark Mode", isOn: $useDarkBackground)
                    } label: {
                        Image(systemName: "textformat.size")
                            .font(.title3)
                    }

                    Spacer()

                    HStack {
                        Text("\(Int(scrollProgress * 100))%")
                            .foregroundColor(useDarkBackground ? .white : .black)
                            .font(.caption)
                            .frame(width: 40)

                        TTSButtonView(viewModelReading: viewModelReading, isSpeaking: $isSpeakingText, text: textContent)
                            .foregroundColor(useDarkBackground ? .white : .black)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)

                GeometryReader { geo in
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(title)
                                        .font(.custom(fontName, size: 32))
                                        .bold()
                                        .foregroundColor(useDarkBackground ? .white : .black)
                                    
                                    Text(author)
                                        .font(.custom(fontName, size: 16))
                                        .italic()
                                        .foregroundColor(useDarkBackground ? .white : .black.opacity(0.8))
                                    
                                    Divider()
                                }
                                .padding(.horizontal)

                                Text(textContent)
                                    .font(.custom(fontName, size: fontSize))
                                    .foregroundColor(useDarkBackground ? .white : .black)
                                    .lineSpacing(4)
                                    .padding(.horizontal)
                                    .padding(.bottom, 40)
                                    .background(GeometryReader {
                                        Color.clear.preference(key: ContentHeightKey.self, value: $0.size.height)
                                    })
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onPreferenceChange(ContentHeightKey.self) { height in
                                contentHeight = height
                            }
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onChange(of: geo.frame(in: .global).minY) { newY in
                                            scrollOffset = -newY
                                        }
                                }
                            )
                        }
                        .onAppear {
                            scrollViewProxy = proxy
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                // removes the guide after you use it once
                                if !dontShow {
                                    showGuide = true
                                    dontShow = true
                                    guideStep = 0
                                }
                            }
                        }
                    }
                }

                VStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 4)
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: max(0, scrollProgress * UIScreen.main.bounds.width), height: 4)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                .background(.ultraThinMaterial)
            }
            .background(useDarkBackground ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))

            // GUIDE OVERLAY
            if showGuide {
                // Dimmed background with hole for focus area
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .mask(
                        Rectangle()
                        // Circle for guide step 0 (only show when guideStep is 0)
                            .overlay(
                                Group {
                                    if guideStep == 0 {
                                        Circle()
                                            .frame(width: 50, height: 50)
                                            .offset(x: -UIScreen.main.bounds.width / 2 + 30, y: -325)
                                            .blendMode(.destinationOut)
                                    }
                                }
                            )
                            // Circle for guide step 1 (only show when guideStep is 1)
                            .overlay(
                                Group {
                                    if guideStep == 1 {
                                        Circle()
                                            .frame(width: 50, height: 50)
                                            .offset(x: 170, y: -325) // Adjust position for guide step 1
                                            .blendMode(.destinationOut)
                                    }
                                }
                            )
                    )
                    .compositingGroup()
                VStack {
                    Spacer()
                    Group {
                        if guideStep == 0 {
                            Text("Use the 'AA' icon to change font, size, and toggle dark mode.")
                            // highlight or arrow the icon
                            
                        } else if guideStep == 1 {
                            Text("Use the speaker button to play or stop the audio narration.")
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()

                    Button(action: {
                        if guideStep < 1 {
                            guideStep += 1
                        } else {
                            showGuide = false
                        }
                    }) {
                        Text(guideStep < 1 ? "Next" : "Got it!")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
                .transition(.opacity)
            }
        }
    }

    var scrollProgress: Double {
        let progress = Double(scrollOffset) / max(1, Double(contentHeight - UIScreen.main.bounds.height))
        return min(max(0, progress), 1.0)
    }
}

struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 1
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TTSButtonView: View {
    @ObservedObject var viewModelReading: TextToSpeechViewModel
    @Binding var isSpeaking: Bool
    let text: String
    
    var body: some View {
        Button {
            if viewModelReading.isSpeaking {
                viewModelReading.stopSpeaking()
                isSpeaking = false
            } else {
                viewModelReading.inputText = text
                viewModelReading.speak()
                isSpeaking = true
            }
        } label: {
            Image(systemName: isSpeaking ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .font(.headline)
        }
    }
}
