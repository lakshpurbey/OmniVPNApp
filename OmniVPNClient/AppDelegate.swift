//
//  AppDelegate.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
    }
    
    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "lock.shield", accessibilityDescription: nil)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Connect", action: #selector(connectVPN), keyEquivalent: "c"))
        menu.addItem(NSMenuItem(title: "Disconnect", action: #selector(disconnectVPN), keyEquivalent: "d"))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func connectVPN() {
        try? AppContainer.shared.connectVPN.execute()
    }
    
    @objc func disconnectVPN() {
        AppContainer.shared.vpnManager.disconnect()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}
