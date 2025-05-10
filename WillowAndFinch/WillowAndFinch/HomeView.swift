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
                    .font(.custom("Times New Roman", size: 28))
                    .bold()
                    .padding(.bottom)
                
                // search bar
                TextField("Search by book title", text: .constant(""))
                    .font(.custom("Times New Roman", size: 16))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                Text("Recommended")
                    .font(.custom("Times New Roman", size: 18))
                ScrollView(.horizontal) {
                    // show the top 5 recommended books
//                    HStack(0..<5) { _ in BookDetailView(title: "Recommended Book")
//                        
//                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
