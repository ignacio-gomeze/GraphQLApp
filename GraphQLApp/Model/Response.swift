//
//  Response.swift
//  GraphQLApp
//
//  Created by Ignacio Gómez on 26-02-21.
//

import Foundation

struct Response: Decodable {
    let books: [Book]
}
