//
//  Untitled.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Combine
import Foundation

final class ConfigManager: ObservableObject {
    
    @Published var configs: [String: Any] = [:]
    
    func load() {
        configs = UserDefaults.standard.dictionary(forKey: "com.apple.configuration.managed") ?? [:]
    }
}
