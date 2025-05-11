//
//  Recommendation.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct RecommendationView: View {
    @State private var recommendationText: String = "Loading recommendation..."
    @State var input = "Enter Book Title"
    @State private var showDetails = false

    var body: some View {
        if #available(iOS 17.0, *) {
            
            // All page
            ZStack {
                Color.sageGreen.ignoresSafeArea(edges: .top)
                
                // All view
                VStack {
                    
                    //TextEditor
                    ZStack {
                        Color(white: 0.95)
                            .cornerRadius(10)
                            .frame(height: 58)

                        CustomTextEditor(text: $input)
                            .frame(height: 58)

                    } //End of ZStacks
                    .padding(.horizontal, 40)
                    
                    // Prints out recommended text info
                    Text(recommendationText)
                        .font(.custom("Didot", size: 28))
                        .padding()
                    
                    // Navigates to BookDetailView
                    if showDetails {
                        NavigationLink(
                            destination: BookDetailView(),
                            label: {
                                HStack {
                                    Text("Book Overview")
                                        .foregroundColor(.black)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.warmBeige)
                                .cornerRadius(12)
                            }
                        )
                    }
                    
                } //end of VStack
                
                // ML algorithm implemented
                .onChange(of: input) {
                    if let bookData = BookRecommendation.loadBookData(),
                       let recommendation = BookRecommendation.recommend(bookTitle: input, from: bookData) {
                        recommendationText = recommendation
                        showDetails = true
                        
                    } else {
                        recommendationText = "No recommendation available"
                        showDetails = false
                    }
                } //end of .onChange
                
            } //end of ZStack
            .background(Color.latteMilk)
        }
    }
}

#Preview {
    RecommendationView()
}

