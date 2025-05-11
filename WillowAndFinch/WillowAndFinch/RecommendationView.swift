//
//  Recommendation.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct RecommendationView: View {
    @State private var recommendationText: String = "Loading recommendation..."

    var body: some View {
        VStack {
            Text(recommendationText)
                .font(.custom("Didot", size: 28))
                .padding()
        }
        .onAppear {
            if let bookData = BookRecommender.loadBookData(),
               let recommendation = BookRecommender.recommend(bookTitle: "Animal Farm", from: bookData) {
                recommendationText = recommendation
            } else {
                recommendationText = "No recommendation available"
            }
        }
    }
}

#Preview {
    RecommendationView()
}

