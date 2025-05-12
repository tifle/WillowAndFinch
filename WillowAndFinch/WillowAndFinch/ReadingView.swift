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
    
    // Track speaking states for each section
    @State private var isSpeakingTitle = false
    @State private var isSpeakingAuthor = false
    @State private var isSpeakingText = false

    let title = "The Yellow Wallpaper"
    let author = "By Charlotte Perkins Gilman"
    
    let textContent = """
    It is very seldom that mere ordinary people like John and myself secure ancestral halls for the summer.

    A colonial mansion, a hereditary estate, I would say a haunted house, and reach the height of romantic felicity—but that would be asking too much of fate!

    Still I will proudly declare that there is something queer about it.

    Else, why should it be let so cheaply? And why have stood so long untenanted?

    John laughs at me, of course, but one expects that in marriage.

    John is practical in the extreme. He has no patience with faith, an intense horror of superstition, and he scoffs openly at any talk of things not to be felt and seen and put down in figures.

    John is a physician, and perhaps—(I would not say it to a living soul, of course, but this is dead paper and a great relief to my mind)—perhaps that is one reason I do not get well faster.

    You see, he does not believe I am sick!

    And what can one do?

    If a physician of high standing, and one's own husband, assures friends and relatives that there is really nothing the matter with one but temporary nervous depression—a slight hysterical tendency—what is one to do?

    My brother is also a physician, and also of high standing, and he says the same thing.

    So I take phosphates or phosphites—whichever it is, and tonics, and journeys, and air, and exercise, and am absolutely forbidden to "work" until I am well again.

    Personally, I disagree with their ideas.

    Personally, I believe that congenial work, with excitement and change, would do me good.

    But what is one to do?

    I did write for a while in spite of them; but it does exhaust me a good deal—having to be so sly about it, or else meet with heavy opposition.

    I sometimes fancy that in my condition if I had less opposition and more society and stimulus—but John says the very worst thing I can do is to think about my condition, and I confess it always makes me feel bad.

    So I will let it alone and talk about the house.

    The most beautiful place! It is quite alone, standing well back from the road, quite three miles from the village. It makes me think of English places that you read about, for there are hedges and walls and gates that lock, and lots of separate little houses for the gardeners and people.

    There is a delicious garden! I never saw such a garden—large and shady, full of box-bordered paths, and lined with long grape-covered arbors with seats under them.

    There were greenhouses, too, but they are all broken now.

    There was some legal trouble, I believe, something about the heirs and co-heirs; anyhow, the place has been empty for years.

    That spoils my ghostliness, I am afraid; but I don't care—there is something strange about the house—I can feel it.
    """

    var body: some View {
        VStack(spacing: 0) {
            // Settings Bar
            HStack {
                // Font Settings Menu (Left-aligned)
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
                    .padding(.vertical)
                    
                    Toggle("Dark Mode", isOn: $useDarkBackground)
                        .padding(.vertical, 5)
                } label: {
                    Image(systemName: "textformat.size")
                        .font(.title3)
                }
                
                Spacer()
                
                // TTS Button (Right-aligned)
                HStack {
                    Text("\(Int(scrollProgress * 100))%")
                        .foregroundColor(useDarkBackground ? .white : .black)
                        .font(.caption)
                        .frame(width: 40)
                    
                    // TTS Controls
                    TTSButtonView(viewModelReading: viewModelReading, isSpeaking: $isSpeakingText, text: textContent)
                        .foregroundColor(useDarkBackground ? .white : .black)
                }
            }
            .padding()
            .background(.ultraThinMaterial)

            // MARK: - Scrollable Text Content
            GeometryReader { geo in
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Title and author section
                            VStack(alignment: .leading, spacing: 8) {
                                Text(title)
                                    .font(fontName == "System" ? .system(size: 32) : .custom(fontName, size: 32))
                                    .bold()
                                    .foregroundColor(useDarkBackground ? .white : .black)
                                
                                Text(author)
                                    .font(fontName == "System" ? .system(size: 16) : .custom(fontName, size: 16))
                                    .italic()
                                    .foregroundColor(useDarkBackground ? .white : .black.opacity(0.8))
                                
                                Divider()
                                    .padding(.vertical, 8)
                            }
                            .padding(.horizontal)
                            
                            // Main text content
                            Text(textContent)
                                .font(fontName == "System" ? .system(size: fontSize) : .custom(fontName, size: fontSize))
                                .foregroundColor(useDarkBackground ? .white : .black)
                                .lineSpacing(4)
                                .padding(.horizontal)
                                .padding(.bottom, 40)
                                .id("textContent")
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
                                    .onAppear {
                                        scrollOffset = geo.frame(in: .global).minY
                                    }
                                    .onChange(of: geo.frame(in: .global).minY) { newY in
                                        scrollOffset = -newY
                                    }
                            }
                        )
                    }
                    .onAppear {
                        scrollViewProxy = proxy
                    }
                }
            }

            // MARK: - Interactive Progress Bar
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    // Background track
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                    
                    // Progress fill
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
    }

    var scrollProgress: Double {
        // Calculate progress as percentage through content
        let progress = Double(scrollOffset) / max(1, Double(contentHeight - UIScreen.main.bounds.height))
        return min(max(0, progress), 1.0)
    }
}

// Helper to track content height
struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 1
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// Simplified TTS Button View
struct TTSButtonView: View {
    @ObservedObject var viewModelReading: TextToSpeechViewModel
    @Binding var isSpeaking: Bool
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
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
}

#Preview {
    ReadingView()
}
