//
//  LogModel.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Foundation

enum LogLevel: String, CaseIterable {
    case info = "INFO"
    case error = "ERROR"
    case debug = "DEBUG"
}

struct LogItem: Identifiable {
    let id = UUID()
    let message: String
    let level: LogLevel
    let timestamp: Date
}
