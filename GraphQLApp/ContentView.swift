//
//  ContentView.swift
//  GraphQLApp
//
//  Created by Ignacio Gómez on 26-02-21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
                    List {
                        ForEach(viewModel.books, id: \.title) { book in
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author!.name)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onAppear {
                        self.viewModel.getData()
                    }
                    .navigationBarTitle("Books")
                }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published private(set) var books: [Book] = []
        
        private let service = WebService()
        
        func getData() {
            self.books.removeAll()
            service.getBooks(onSuccess: { [weak self] books in
                self?.books = books
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentView.ViewModel())
    }
}
