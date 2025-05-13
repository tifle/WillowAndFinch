//
//  HomeView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct HomeView: View {
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
                    Text("Welcome to Willow & Finch")
                        .font(.custom("Georgia", size: 25))
                        .foregroundColor(Color("TextColor"))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    
                    // search bar
                    TextField("Search by book title", text: .constant(""))
                        .font(.custom("Avenir", size: 16))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 380)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    
                    Text("Recommended")
                        .font(.custom("Georgia", size: 18))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                    
                    //Add lots of HStacks lol
                    ScrollView(.horizontal) {
                    }
            }
                .background(Color("BackgroundColor").ignoresSafeArea(edges: .top))
                .background(Color("TabColor"))

                
        }
    }
}

#Preview {
    HomeView()
}
