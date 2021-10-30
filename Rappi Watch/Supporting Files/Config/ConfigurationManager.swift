//
//  ConfigurationManager.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

class ConfigurationManager {
    func readConfiguration() -> [String: String]? {
        guard let pathOfPlist = Bundle.main.path(forResource: "Configuration", ofType: "plist") else { return nil }
        
        let url = URL(fileURLWithPath: pathOfPlist)
        let data = try! Data(contentsOf: url)
        
        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] else { return nil }
        return plist
    }
}
