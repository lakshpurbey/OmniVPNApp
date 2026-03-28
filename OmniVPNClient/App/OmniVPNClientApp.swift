//
//  OmniVPNClientApp.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import SwiftUI

@main
struct OmniVPNClientApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
