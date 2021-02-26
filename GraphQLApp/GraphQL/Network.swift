//
//  Network.swift
//  GraphQLApp
//
//  Created by Ignacio Gómez on 26-02-21.
//

import Foundation

typealias successHandler = (_ data: [Book]) -> Void
typealias errorHandler = (_ error: Error) -> Void

class WebService {
    func getBooks(onSuccess: @escaping successHandler, onError: errorHandler? = nil) {
        let query = """
            query Books {
              books {
                  title
                  author {
                    name
                  }
                }
            }
        """
        
        let parameters = ["query": query]
        var postData: Data?
        do {
            postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch (let error) {
            debugPrint(error)
        }
        var request = URLRequest(url: URL(string: "http://localhost:4000/graphql")!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        request.httpBody = postData
        let dataTask = URLSession.shared.dataTask(with: request,
                                                  completionHandler: { (data, response, error) -> Void in
                                                    if (error != nil) {
                                                        debugPrint(error.debugDescription)
                                                    } else if (data != nil) {
                                                        do {
                                                            let result = try JSONDecoder().decode(GraphqlEndpoint.self, from: data!)
                                                            onSuccess(result.data.books)
                                                        } catch (let error) {
                                                            debugPrint(error)
                                                        }
                                                    }
                                                  })
        dataTask.resume()
    }
}
