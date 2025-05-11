//
//  BookRecommendation.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/6/25.
//

import Foundation

class BookRecommendation {
    static func loadBookData() -> BookData? {
        guard let url = Bundle.main.url(forResource: "book_data_cleaned", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Could not find book_data_cleaned.json.")
            return nil
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(BookData.self, from: data)
        } catch {
            print("Error decoding book data: \(error)")
            return nil
        }
    }

    static func recommend(bookTitle: String, from data: BookData) -> String? {
        guard let index = data.book_titles.firstIndex(of: bookTitle) else {
            return "Book '\(bookTitle)' not found in dataset."
        }

        let similarities = data.similarity_scores[index]
        let indexedSimilarities = similarities.enumerated().sorted { $0.element > $1.element }
        let top = indexedSimilarities.dropFirst().prefix(5)

        if let selected = top.randomElement() {
            let recommendedTitle = data.book_titles[selected.offset]
            let author = data.book_authors[recommendedTitle] ?? "Unknown"
            return "Title: \(recommendedTitle)\nAuthor: \(author)"
        }

        return nil
    }
}

