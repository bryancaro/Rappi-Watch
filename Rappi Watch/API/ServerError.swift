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
            return NSLocalizedString("server_error_description".localized, comment: "")
            
        case .decodingError:
            return NSLocalizedString("decoding_error_description".localized, comment: "")
        }
    }
}
