//
//  LogStore.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Foundation
import Combine

final class LogStore: ObservableObject {
    
    static let shared = LogStore()
    
    @Published var logs: [String] = []
    
    private var timer: Timer?
    
    func startListening() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.loadLogs()
        }
    }
    
    func stopListening() {
        timer?.invalidate()
    }
    
    private func loadLogs() {
        let defaults = UserDefaults(suiteName: "group.com.company.omnivpn")
        self.logs = defaults?.array(forKey: "logs") as? [String] ?? []
    }
}
