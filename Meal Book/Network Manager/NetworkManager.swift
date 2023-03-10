//
//  NetworkManager.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation
import Combine

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    private func loadData(for request: URLRequest?) -> AnyPublisher<Data, Error> {
        guard let request, let url = request.url else {
            return Fail(error: NetworkError.invalidURLError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.invalidAPIResponse
                }
                
                return data
            })
            .eraseToAnyPublisher()
    }
}

// API requests
extension NetworkManager {
    enum MethodType: String {
        case GET
        case POST
        case DELETE
    }
    
    func GET(
        _ urlString: String,
        queryParameters: [String: String]?
    ) -> AnyPublisher<Data, Error> {
        let urlRequest = URLRequest.createURLRequest(
            for: urlString,
            methodType: .GET,
            queryParameters: queryParameters
        )
        
        return self.loadData(for: urlRequest)
    }
    
    func POST(
        _ urlString: String,
        bodyParameters: [String: Any]?
    ) -> AnyPublisher<Data, Error> {
        let urlRequest = URLRequest.createURLRequest(
            for: urlString,
            methodType: .POST,
            bodyParameters: bodyParameters
        )
        return self.loadData(for: urlRequest)
    }
}
