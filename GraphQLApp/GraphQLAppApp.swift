//
//  GraphQLAppApp.swift
//  GraphQLApp
//
//  Created by Ignacio Gómez on 26-02-21.
//

import SwiftUI

@main
struct GraphQLAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentView.ViewModel())
        }
    }
}
