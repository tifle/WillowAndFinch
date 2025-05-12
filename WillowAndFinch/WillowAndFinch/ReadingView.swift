//
//  R0.eadingView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

import SwiftUI

// MARK: - Main ReadingView
struct ReadingView: View {
    @StateObject private var viewModelReading = TextToSpeechViewModel()
    @State private var fontName: String = "Avenir"
    @State private var fontSize: CGFloat = 16
    @State private var useDarkBackground: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 1
    @State private var showGuide = false
    @State private var guideStep = 0
    @State private var dontShow = false
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
                SettingsBar(fontName: $fontName, fontSize: $fontSize, useDarkBackground: $useDarkBackground, scrollProgress: scrollProgress, viewModelReading: viewModelReading, isSpeakingText: $isSpeakingText, textContent: textContent)
                ScrollViewContent(title: title, author: author, textContent: textContent, fontName: fontName, fontSize: fontSize, useDarkBackground: useDarkBackground, contentHeight: $contentHeight, scrollOffset: $scrollOffset)
                ProgressBar(scrollProgress: scrollProgress)
            }
            .background(useDarkBackground ? Color.black.edgesIgnoringSafeArea(.all) : Color("BackgroundColor").edgesIgnoringSafeArea(.all))
            GuideOverlay(showGuide: $showGuide, guideStep: $guideStep, dontShow: $dontShow)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if !dontShow {
                    showGuide = true
                    dontShow = true
                    guideStep = 0
                }
            }
        }
    }

    var scrollProgress: Double {
        let progress = Double(scrollOffset) / max(1, Double(contentHeight - UIScreen.main.bounds.height))
        return min(max(0, progress), 1.0)
    }
}

// MARK: - SettingsBar
struct SettingsBar: View {
    @Binding var fontName: String
    @Binding var fontSize: CGFloat
    @Binding var useDarkBackground: Bool
    var scrollProgress: Double
    @ObservedObject var viewModelReading: TextToSpeechViewModel
    @Binding var isSpeakingText: Bool
    let textContent: String

    var body: some View {
        HStack {
            HStack(spacing: 16) {
                ThemeToggle(useDarkBackground: $useDarkBackground)
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
                } label: {
                    Image(systemName: "textformat.size")
                        .font(.title3)
                }
            }
            Spacer()
            HStack(spacing: 8) {
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
    }
}

// MARK: - ScrollViewContent
struct ScrollViewContent: View {
    let title: String
    let author: String
    let textContent: String
    let fontName: String
    let fontSize: CGFloat
    let useDarkBackground: Bool
    @Binding var contentHeight: CGFloat
    @Binding var scrollOffset: CGFloat

    var body: some View {
        GeometryReader { geo in
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
        }
    }
}

// MARK: - ProgressBar
struct ProgressBar: View {
    var scrollProgress: Double

    var body: some View {
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
}

// MARK: - GuideOverlay
struct GuideOverlay: View {
    @Binding var showGuide: Bool
    @Binding var guideStep: Int
    @Binding var dontShow: Bool

    var body: some View {
        if showGuide {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .mask(
                    Rectangle()
                        .overlay(
                            Group {
                                if guideStep == 0 {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .offset(x: -UIScreen.main.bounds.width / 2 + 34, y: -320)
                                        .blendMode(.destinationOut)
                                } else if guideStep == 1 {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .offset(x: -UIScreen.main.bounds.width / 2 + 82, y: -320)
                                        .blendMode(.destinationOut)
                                } else if guideStep == 2 {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .offset(x: -UIScreen.main.bounds.width / 2 + 323, y: -320)
                                        .blendMode(.destinationOut)
                                } else if guideStep == 3 {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .offset(x: -UIScreen.main.bounds.width / 2 + 363, y: -320)
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
                        Text("Use the button to toggle between light and dark mode for reading.")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(Color("TextColor"))
                    } else if guideStep == 1 {
                        Text("Use the 'AA' icon to change font and size.")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(Color("TextColor"))
                    }else if guideStep == 2 {
                        Text("Check your reading progress")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(Color("TextColor"))
                    }else if guideStep == 3 {
                        Text("Use the speaker button to play or stop the audio narration.")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(Color("TextColor"))
                    }
                }
                .multilineTextAlignment(.center)
                .padding()
                .background(Color("BackgroundColor"))
                .cornerRadius(12)
                .padding()
                Button(action: {
                    if guideStep < 3 {
                        guideStep += 1
                    } else {
                        showGuide = false
                    }
                }) {
                    Text(guideStep < 3 ? "Next" : "Got it!")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Matcha"))
                        .foregroundColor(Color("BackgroundColor"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .transition(.opacity)
        }
    }
}

// MARK: - ContentHeightKey
struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 1
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - TTSButtonView
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

// MARK: - ThemeToggle
struct ThemeToggle: View {
    @Binding var useDarkBackground: Bool

    var body: some View {
        Button(action: {
            useDarkBackground.toggle()
        }) {
            Image(systemName: useDarkBackground ? "moon.fill" : "sun.max.fill")
                .font(.system(size: 18))
                .foregroundColor(useDarkBackground ? .blue : .yellow)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill(useDarkBackground ? Color.black : Color("BackgroundColor"))
                        .frame(width: 36, height: 36)
                        .shadow(radius: 2)
                )
        }
    }
}
