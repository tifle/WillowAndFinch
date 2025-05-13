//
//  ContentView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    var body: some View {
        TabView (selection: $selection){
            HomeView()
                .tabItem {
                    Image (systemName: "house")
                    Text("Home")
                }
                .tag(1)
            RecommendationView()
                .tabItem {
                    Image (systemName: "sparkles")
                    Text("For You")
                }
                .tag(2)
            
            FinchNestView()
                .tabItem {
                    Image (systemName: "books.vertical")
                    Text("Finch Nest")
                }
                .tag(3)
            
            MoreInfoView()
                .tabItem{
                    Image(systemName: "info.circle")
                    Text("More Info")
                }
                .tag(4)
            
            ReadingView()
                .tabItem{
                    Image(systemName: "book.pages.fill")
                    Text("Read")
                }
                .tag(5)
//            BookDetailView()
//                .tabItem{
//                    Image(systemName: "book.pages.fill")
//                    Text("Read")
//                }
//                .tag(6)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
