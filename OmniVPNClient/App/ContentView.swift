//
//  ContentView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationSplitView {
                  SidebarView()
              } detail: {
                  DashboardView()
              }
              .frame(minWidth: 900, minHeight: 500)
    }
}

#Preview {
    ContentView()
}

struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(value == "--" ? .gray : .primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
    }
}
