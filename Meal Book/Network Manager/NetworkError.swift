//
//  NetworkError.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURLError
    case invalidAPIResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURLError:
            return NSLocalizedString("URL is nil or not valid.", comment: "")
        case .invalidAPIResponse:
            return NSLocalizedString("Invalid API response or received an error in api response", comment: "")
        }
    }
}
