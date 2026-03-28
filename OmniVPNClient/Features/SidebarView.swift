//
//  SidebarView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct SidebarView: View {
    
    var body: some View {
        List {
            Label("Dashboard", systemImage: "speedometer")
            Label("Logs", systemImage: "doc.text")
            Label("Settings", systemImage: "gearshape")
        }
        .navigationTitle("Omni VPN")
    }
}
