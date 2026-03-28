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
    
    @Published var logs: [LogItem] = []
    
    private var timer: Timer?
    
    private init() {}

    func startListening() {
        loadLogs()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.generateMockLog()
        }
    }
    
    func stopListening() {
        timer?.invalidate()
        timer = nil

    }
    
    private func loadLogs() {
          // Load from shared container if needed
      }
    
    func addLog(_ message: String, level: LogLevel) {
           let log = LogItem(message: message, level: level, timestamp: Date())
           logs.append(log)
       }
       
    private func generateMockLog() {
           let levels: [LogLevel] = [.info, .error, .debug]
           let random = levels.randomElement()!
           
           addLog("Sample \(random.rawValue) log at \(Date())", level: random)
    }
}
