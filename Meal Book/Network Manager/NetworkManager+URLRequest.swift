//
//  NetworkManager+URLRequest.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

extension URLRequest {
    static func createURLRequest(
        for urlString: String,
        methodType: NetworkManager.MethodType,
        queryParameters: [String: String]? = nil,
        bodyParameters: [String: Any]? = nil
    ) -> URLRequest? {
        var urlComponent = URLComponents(string: urlString)
        
        if methodType == .GET, let queryParameters = queryParameters{
            urlComponent?.queryItems = queryParameters.map { (key: String, value: String) in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = urlComponent?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: TimeInterval(30))
        
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        urlRequest.httpMethod = methodType.rawValue

        if let bodyParameters = bodyParameters,
           let data = try? JSONSerialization.data(withJSONObject: bodyParameters) {
            urlRequest.httpBody = data
        }
        
        return urlRequest
    }
}
