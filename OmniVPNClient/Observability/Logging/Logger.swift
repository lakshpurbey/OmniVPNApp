//
//  Logger.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

enum Logger {

    static func info(_ message: String) {
        print("INFO: \(message)")
    }

    static func error(_ message: String) {
        print("ERROR: \(message)")
    }
}
