//
//  DashboardView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: Header
            HStack {
                Text("Dashboard")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(viewModel.isConnected ? "Disconnect" : "Connect") {
                    viewModel.toggleVPN()
                }
                .buttonStyle(.borderedProminent)
            }
            
            // MARK: VPN Status Card
            HStack(spacing: 20) {
                
                Circle()
                    .fill(viewModel.isConnected ? Color.green : Color.red)
                    .frame(width: 14, height: 14)
                
                VStack(alignment: .leading) {
                    Text(viewModel.statusText)
                        .font(.title2)
                        .bold()
                    
                    Text(viewModel.isConnected ? "Secure connection active" : "Not connected")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            
            // MARK: Stats
            HStack(spacing: 16) {
                StatCard(title: "Latency", value: viewModel.latency)
                StatCard(title: "Traffic", value: viewModel.traffic)
                StatCard(title: "Uptime", value: viewModel.uptime)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Traffic Overview")
                    .font(.headline)
                TrafficGraphView(data: viewModel.trafficData)
            }
            .padding()
            .background(Color.gray.opacity(0.08))
            .cornerRadius(12)
            
            // MARK: Activity Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Activity")
                    .font(.headline)
                
                Text("Network activity and logs will appear here...")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .onAppear { viewModel.startGraphUpdates() }
        .onDisappear { viewModel.stopGraphUpdates() }
    }
}
