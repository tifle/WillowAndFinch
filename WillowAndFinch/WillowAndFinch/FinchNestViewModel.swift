//
//  FinchNestViewModel.swift
//  WillowAndFinch
//
//  Created by Tiffany Le on 5/13/25.
//

import Foundation
import SwiftUI

class FinchNestViewModel: ObservableObject {
    @Published var savedBooks: [Book] = [] // holds the list of saved books
        
    // function to add a book to the savedBooks list
    func addSaved(_ book: Book) {
        savedBooks.append(book)
    }

    func isBookSaved(_ book: Book) -> Bool {
        savedBooks.contains(where: { $0.id == book.id })
    }
}
