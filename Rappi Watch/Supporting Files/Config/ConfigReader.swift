//
//  ConfigReader.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

class ConfigReader: NSObject {
    static func baseUrl() -> String {
        valueFromPlist("baseUrl")!
    }
    
    static func apiKey() -> String {
        valueFromPlist("key")!
    }
    
    static func imgBaseUrl() -> String {
        valueFromPlist("imgBaseUrl")!
    }
    
    static func valueFromPlist(_ key: String) -> String? {
        guard let dictionary = ConfigurationManager().readConfiguration() else { return nil }
        return dictionary[key]
    }
}
