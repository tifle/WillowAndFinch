//
//  BookData.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/11/25.
//

import Foundation

struct BookData: Decodable {
    let book_titles: [String]
    let book_metadata: [String: BookMetadata]
    let similarity_scores: [[Double]]
}
