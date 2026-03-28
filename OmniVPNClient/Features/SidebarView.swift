//
//  SidebarView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct SidebarView: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: DashboardView()) {
                    Label("Dashboard", systemImage: "speedometer")
                }
                
                NavigationLink(destination: LogsView()) {
                    Label("Logs", systemImage: "doc.text")
                }
                
                NavigationLink(destination: SettingsView()) {
                    Label("Settings", systemImage: "gearshape")
                }
            }
            .navigationTitle("Omni VPN")
        }
    }
}
