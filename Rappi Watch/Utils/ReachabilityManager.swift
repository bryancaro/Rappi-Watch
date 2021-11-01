//
//  ReachabilityManager.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/1/21.
//

import Foundation
import Reachability

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    let reachability = try? Reachability()
    var reachable : Bool?
    
    init() {
        self.reachable = false
        
        reachability!.whenReachable = { reachability in
            if reachability.connection == .wifi {
                self.reachable = true
                print("Reachable via WiFi")
            } else {
                self.reachable = true
                print("Reachable via Cellular")
            }
        }
        
        reachability!.whenUnreachable = { _ in
            self.reachable = false
            print("Not reachable")
        }
        
        do {
            try reachability!.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func isConnected() -> Bool {
        var isNetAvailable = false;
        
        let reach = try? Reachability(hostname: "www.google.com")
        let netStatus = reach!.connection
        if (netStatus != .unavailable) {
            isNetAvailable = true;
        } else {
            isNetAvailable = false;
        }
        return isNetAvailable
    }
}
