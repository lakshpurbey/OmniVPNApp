//
//  Untitled.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Combine
import Foundation

final class ConfigManager: ObservableObject {
    
    static let shared = ConfigManager()
    
    @Published var configs: [String: Any] = [:]
    
    private init() {}
    
    func load() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.company.omnivpn")
        
        if let dict = sharedDefaults?.dictionary(forKey: "mdm_config") {
            DispatchQueue.main.async {
                self.configs = dict
            }
        } else {
            // Demo fallback
            configs = [
                "Server": "vpn.company.com",
                "Port": 443,
                "Protocol": "IKEv2",
                "Auto Connect": true
            ]
        }
    }
}
