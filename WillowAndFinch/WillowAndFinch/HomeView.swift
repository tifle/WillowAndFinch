////
////  HomeView.swift
////  WillowAndFinch
////
////  Created by Yanelly Mego on 5/4/25.
////

import SwiftUI

struct HomeView: View {
    @ObservedObject var recommender = BookRecommendation.shared
    @State private var refreshID = UUID()
    
    // helps with book cover loading
    struct BookCoverView: View {
        let imageURL: String
        let title: String
        @State private var hasAppeared = false
        
        var body: some View {
            VStack {
                // URLCache improves image loading
                if let url = URL(string: imageURL) {
                    CachedAsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 120)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 120)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        case .failure(let error):
                            VStack {
                                Image("DefaultCover")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 120)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                if hasAppeared {
                                    Text("Error: \(error.localizedDescription)")
                                        .font(.system(size: 8))
                                        .foregroundColor(.red)
                                        .frame(width: 80)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                } else {
                    Image("DefaultCover")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 120)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            Text("Invalid URL")
                                .font(.system(size: 10))
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(4),
                            alignment: .bottom
                        )
                }
                
            }
            .padding(.horizontal, 4)
            .onAppear {
                // mark that view has appeared to show error messages if needed
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    hasAppeared = true
                }
            }
        }
    }
    
    // custom CachedAsyncImage for handling caching better
    struct CachedAsyncImage<Content: View>: View {
        private let url: URL
        private let content: (AsyncImagePhase) -> Content
        
        init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
            self.url = url
            self.content = content
        }
        
        var body: some View {
            AsyncImage(url: url, scale: 1.0, transaction: Transaction(animation: .default)) { phase in
                content(phase)
            }
            // key modifiers ensure proper loading
            .id(url.absoluteString)
        }
    }
    
    var body: some View {
        // Navigation View
        NavigationView {
            
            // Vertical Stack
            VStack(alignment: .leading) {
                
                // Logo / Home Page
                HStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Spacer()
                }
                .padding(.top)
                
                //title
                Text("Welcome to Willow & Finch")
                    .font(.custom("Georgia", size: 25))
                    .foregroundColor(Color("TextColor"))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom)
                
                //recommended section
                ScrollView(.vertical){
                    Text("Recommended")
                        .font(.custom("Georgia", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding()
                    
                    if recommender.recommendedBooks.isEmpty {
                        NavigationLink(destination: RecommendationView()) {
                            Text("Generate recommendations")
                                .frame(width: 230, height: 30)
                                .background(Color.sageGreen)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 12) {
                                ForEach(recommender.recommendedBooks, id: \.title) { book in
                                    BookCoverView(imageURL: book.imageURL, title: book.title)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .id(refreshID) // force redraw with refreshID
                        
                        NavigationLink(destination: RecommendationView()) {
                            Text("Generate more")
                                .frame(width: 140, height: 30)
                                .background(Color.sageGreen)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(.vertical)
                    } //end of scroll view
                    
                    // new releases section
                    Text("New Releases")
                        .font(.custom("Georgia", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding(.top, 30)
                    
                    // book scrollable list
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Image("WingsOfStarlight")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("SunriseOnTheReaping")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("EmilyWilde")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("MarkTwain")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("OnyxStorm")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("GirlWhoFellBeneathTheSea")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("OneGoldenSummer")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("EverythingIsTuberculosis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("NextDay")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .padding(.horizontal)
                    }
                    
                    // staff choice section
                    Text("Staff's Choice")
                        .font(.custom("Georgia", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding(.top, 30)
                    
                    // cover scrollable list
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Image("TheWager")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("Cinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("MagicTreeHouse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("GentlemanInMoscow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("MeBeforeYou")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("HungerGames")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("Illuminae")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("MidnightLibrary")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image("SixOfCrows")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color("BackgroundColor").ignoresSafeArea(edges: .top))
            .background(Color("TabColor"))
            .onAppear {
                // force refresh when view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    refreshID = UUID()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(FinchNestViewModel())
}
