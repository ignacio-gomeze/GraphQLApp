//
//  Book.swift
//  GraphQLApp
//
//  Created by Ignacio Gómez on 26-02-21.
//

import Foundation

struct Book: Decodable {
    let title: String
    let author: Author?
}
