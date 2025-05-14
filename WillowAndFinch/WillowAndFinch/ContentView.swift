//
//  ContentView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    @StateObject private var finchNestViewModel = FinchNestViewModel()

    var body: some View {
        TabView (selection: $selection){
            HomeView()
                .tabItem {
                    Image (systemName: "house")
                    Text("Home")
                }
                .tag(1)
            SearchView()
                .tabItem {
                    Image (systemName: "magnifyingglass")
                    Text("Search")
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
        }
        .environmentObject(finchNestViewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(FinchNestViewModel())
}
