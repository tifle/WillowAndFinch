//
//  Book.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/12/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let publication_year: Int
    let publisher: String
    let imageURL: String
}
