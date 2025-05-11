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
                        .font(.custom("Didot", size: 28))
                    //                    .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    
                    // search bar
                    TextField("Search by book title", text: .constant(""))
                        .font(.custom("Didot", size: 16))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 380)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    
                    Text("Recommended")
                        .font(.custom("Didot", size: 18))
                    ScrollView(.horizontal) {
                        // show the top 5 recommended books
                        //                    HStack(0..<5) { _ in BookDetailView(title: "Recommended Book")
                        //                        
                    //                    }
                    } //end of scroll view
            } //end of VStack
                .background(Color.sageGreen.ignoresSafeArea(edges: .top))
                .background(Color.latteMilk)

                
        } //end of navigation view
    }
}

#Preview {
    HomeView()
}
