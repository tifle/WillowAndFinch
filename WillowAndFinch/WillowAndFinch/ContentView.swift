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
                    Image (systemName: "01.circle")
                    Text("Home")
                }
                .tag(1)
            FYPView()
                .tabItem {
                    Image (systemName: "02.circle")
                    Text("For You Page")
                }
                .tag(2)
            
            FinchNestView()
                .tabItem {
                    Image (systemName: "03.circle")
                    Text("Finch Nest")
                }
                .tag(3)
            
            MoreInfoView()
                .tabItem{
                    Image(systemName: "04.circle")
                    Text("More Info")
                }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
}
