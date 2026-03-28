//
//  DashboardView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    @StateObject private var logStore = LogStore.shared
    
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

            VStack(alignment: .leading, spacing: 10) {
                Text("Recent Logs")
                    .font(.headline)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(Array(logStore.logs.prefix(10)), id: \.id) { log in
                            LogRowView(log: log)
                        }
                    }
                }
                .frame(maxHeight: 150)
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
private struct LogRowView: View {
    let log: LogItem

    private var timestampDate: Date {
        // Try common representations first, then fall back to now.
        if let d = log.timestamp as? Date { return d }
        // Try Mirror to unwrap optionals or wrappers
        if case let mirror = Mirror(reflecting: log.timestamp),
           let child = mirror.children.first?.value as? Date { return child }
        // Try KVC-style access if available
        if let anyObj = log as AnyObject?,
           let wrapped = anyObj.value(forKey: "wrappedValue") as? Date {
            return wrapped
        }
        return Date()
    }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(timestampDate, style: .time)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 60, alignment: .leading)
            Text(log.level.rawValue.uppercased())
                .font(.caption2)
                .bold()
                .foregroundColor(log.level.color)
                .frame(width: 50, alignment: .leading)
            Text(log.message)
                .font(.caption)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

extension LogLevel {
    var color: Color {
        let name = String(describing: self).lowercased()
        switch name {
        case "debug":
            return .gray
        case "info":
            return .blue
        case "warn", "warning":
            return .orange
        case "error":
            return .red
        default:
            return .primary
        }
    }
}
