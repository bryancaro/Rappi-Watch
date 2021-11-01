//
//  ServerError.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/1/21.
//

import Foundation

enum ServerError: Error, LocalizedError {
    case serverError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return NSLocalizedString("Sorry for the inconvenience, please try again later!", comment: "")
            
        case .decodingError:
            return NSLocalizedString("Sorry for the inconvenience, please contact the developer!", comment: "")
        }
    }
}
