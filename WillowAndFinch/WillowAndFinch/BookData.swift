//
//  BookData.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/11/25.
//

import Foundation

struct BookData: Codable {
    let book_titles: [String]
    let book_authors: [String: String]
    let similarity_scores: [[Double]]
}
