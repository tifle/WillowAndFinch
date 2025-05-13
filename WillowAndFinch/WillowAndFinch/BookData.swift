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

struct BookMetadata: Decodable {
    let BookAuthor: String
//    let ISBN: String
    let YearOfPublication: Int
    let Publisher: String
//    let ImageURLS: String
//    let ImageURLM: String
    let ImageURL: String

    // Match JSON keys with Swift variable names
    private enum CodingKeys: String, CodingKey {
        case BookAuthor = "Book-Author"
//        case ISBN
        case YearOfPublication = "Year-Of-Publication"
        case Publisher
//        case ImageURLS = "Image-URL-S"
//        case ImageURLM = "Image-URL-M"
        case ImageURL = "Image-URL-L"
    }
}
