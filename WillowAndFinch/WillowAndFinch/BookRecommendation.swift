//
//  BookRecommendation.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/6/25.
//

import Foundation

class BookRecommendation: ObservableObject {
    static let shared = BookRecommendation()
    @Published var lastIndexedSimilarities: ArraySlice<(offset: Int, element: Double)> = []
    @Published var recommendedBooks: [Book] = []
    
    //checks for JSON file to decode
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

    // function called by recommendationview
    static func recommend(bookTitle: String, from data: BookData) -> (Book?, String?) {
        guard let index = data.book_titles.firstIndex(of: bookTitle) else {
            return (nil, "Book '\(bookTitle)' not found in dataset.")
        }
        
        //for home page
        BookRecommendation.shared.recommendedlist(bookTitle: bookTitle, from: data)

        let similarities = data.similarity_scores[index]
        let indexedSimilarities = similarities.enumerated().sorted { $0.element > $1.element }
        let top = indexedSimilarities.dropFirst().prefix(9)

        if let selected = top.randomElement() {
            let recommendedTitle = data.book_titles[selected.offset]
            guard let metadata = data.book_metadata[recommendedTitle] else {
                return (nil, nil)
            }
            return (Book(
                title: recommendedTitle,
                author: metadata.BookAuthor,
                publication_year: metadata.YearOfPublication,
                publisher: metadata.Publisher,
                imageURL: metadata.ImageURL
            ), nil)
        }
        return (nil, nil)
    }
    
    // used by home page
    func recommendedlist(bookTitle: String, from data: BookData) -> [Book]{
        guard let index = data.book_titles.firstIndex(of: bookTitle) else {
            return []
        }
                
        let similarities = data.similarity_scores[index]
        let indexedSimilarities = similarities.enumerated().sorted { $0.element > $1.element }
        let top = indexedSimilarities.dropFirst().prefix(9)
        self.lastIndexedSimilarities = top
        
        for selected in top {
            let recommendedTitle = data.book_titles[selected.offset]
            if let metadata = data.book_metadata[recommendedTitle] {
                let book = Book(
                    title: recommendedTitle,
                    author: metadata.BookAuthor,
                    publication_year: metadata.YearOfPublication,
                    publisher: metadata.Publisher,
                    imageURL: metadata.ImageURL
                )
                recommendedBooks.append(book)
            }
        }
        return recommendedBooks
    }
    
}
