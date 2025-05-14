//
//  BookMetadata.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/14/25.
//

struct BookMetadata: Decodable {
    let BookAuthor: String
    let YearOfPublication: Int
    let Publisher: String
    let ImageURL: String

    // JSON keys matched w/ Swift variable names
    private enum CodingKeys: String, CodingKey {
        case BookAuthor = "Book-Author"
        case YearOfPublication = "Year-Of-Publication"
        case Publisher
        case ImageURL = "Image-URL-L"
    }
}
