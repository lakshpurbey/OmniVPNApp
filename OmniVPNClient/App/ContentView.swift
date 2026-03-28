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
        VStack(spacing: 20) {
            
            // MARK: - Header
            VStack(spacing: 4) {
                Text("Omni VPN")
                    .font(.largeTitle)
                    .bold()
                
                Text("Secure Enterprise Connection")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // MARK: - Status Card
            VStack(spacing: 16) {
                
                Circle()
                    .fill(viewModel.isConnected ? Color.green : Color.red)
                    .frame(width: 16, height: 16)
                    .shadow(color: viewModel.isConnected ? .green : .red, radius: 8)
                
                Text(viewModel.statusText)
                    .font(.title2)
                    .bold()
                
                Text(viewModel.isConnected ? "Your connection is secure" : "Not connected")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black.opacity(0.2))
            .cornerRadius(16)
            
            // MARK: - Connect Button
            Button(action: {
                viewModel.toggleVPN()
            }) {
                Text(viewModel.isConnected ? "Disconnect" : "Connect")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isConnected ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            // MARK: - Stats Section
            HStack(spacing: 16) {
                StatCard(title: "Latency", value: viewModel.latency)
                StatCard(title: "Traffic", value: viewModel.traffic)
                StatCard(title: "Uptime", value: viewModel.uptime)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 420, height: 320)
        .background(Color(NSColor.windowBackgroundColor))
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
