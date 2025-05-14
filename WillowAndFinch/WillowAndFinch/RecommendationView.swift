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
    @State private var bookRecommendation: (Book?, String?) = (nil, nil)

    
    var body: some View {
        if #available(iOS 17.0, *) {
            
            NavigationView {
                // All page
                ZStack {
                    Color("BackgroundColor").ignoresSafeArea(edges: .top)
                    
                    // All view
                    VStack {
                        
                        Text("Enter the title of your favorite book!")
                            .font(.custom("Avenir", size: 30))
                            .bold()
                            .foregroundColor(Color("TextColor"))
                            .padding()
                        
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
                            .font(.custom("Avenir", size: 26))
                            .foregroundColor(Color("TextColor"))
                            .padding()
                        
                        // Navigates to BookDetailView
                        //                        if showDetails, let recommendation = bookRecommendation {
                        if showDetails,
                           let recommendation = bookRecommendation.0{
                            
                            // Appears when the recommendation is ready
                            NavigationLink(
                                destination: BookDetailView(book: Book(
                                    title: recommendation.title,
                                    author: recommendation.author,
                                    publication_year: recommendation.publication_year,
                                    publisher: recommendation.publisher,
                                    imageURL: recommendation.imageURL)),
                                label: {
                                    HStack {
                                        Text("Book Overview")
                                            .foregroundColor(Color("TextColor"))
                                            .font(.custom("Avenir", size: 26))
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
                            if let bookData = BookRecommendation.loadBookData(){
                                bookRecommendation = BookRecommendation.recommend(bookTitle: input, from: bookData)
                                showDetails = true

                                let (rec, message) = bookRecommendation

                                if rec == nil {
                                    recommendationText = message!
                                } else {
                                    recommendationText = "Recommended Title: \(rec?.title ?? "")\nAuthor: \(rec?.author ?? "")"
                                }
                            } else {
                                recommendationText = "No recommendation available"
                                showDetails = false
                            }
                        } //end of .onChange
                    } //end of ZStack
                    .background(Color("TabColor"))
                }
            }
        }
}

#Preview {
    RecommendationView()
}
