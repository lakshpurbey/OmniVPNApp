//
//  LogsView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct LogsView: View {
    

    @StateObject private var store = LogStore.shared
    
    @State private var selectedLevel: LogLevel? = nil

    var filteredLogs: [LogItem] {
        if let level = selectedLevel {
            return store.logs.filter { $0.level == level }
        }
        return store.logs
    }


    var body: some View {
        VStack(spacing: 0) {
            
            // Filter Bar
            filterBar
            
            Divider()
            
            // Logs List (Auto-scroll)
            ScrollViewReader { proxy in
                List(filteredLogs) { log in
                    logRow(log)
                        .id(log.id)
                }
                .onChange(of: store.logs.count) { _, _ in
                    if let last = filteredLogs.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
        }
        .onAppear {
                   store.startListening()
               }
               .onDisappear {
                   store.stopListening()
               }
    }
    
    var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All") { selectedLevel = nil }
                
                ForEach(LogLevel.allCases, id: \.self) { level in
                    Button(level.rawValue) {
                        selectedLevel = level
                    }
                    .foregroundColor(color(for: level))
                }
            }
            .padding(8)
        }
    }
    
    func logRow(_ log: LogItem) -> some View {
        HStack(alignment: .top, spacing: 8) {
            
            Text(timeFormatter.string(from: log.timestamp))
                .font(.caption2)
                .foregroundColor(.gray)
            
            Text("[\(log.level.rawValue)]")
                .font(.caption2)
                .foregroundColor(color(for: log.level))
            
            Text(log.message)
                .font(.caption)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
    
    func color(for level: LogLevel) -> Color {
        switch level {
        case .info: return .blue
        case .error: return .red
        case .debug: return .gray
        }
    }

    let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss"
        return f
    }()
    
}
