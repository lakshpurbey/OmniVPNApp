//
//  LogsView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct LogsView: View {
    
    @State private var logs: [String] = []
    @StateObject private var store = LogStore.shared

    var body: some View {
        VStack {
            Text("Logs")
                .font(.title)
            
            List(logs, id: \.self) { log in
                Text(log)
                    .font(.caption)
            }
        }
//        .onAppear {
//            loadLogs()
//        }
        
        .onAppear {
                   store.startListening()
               }
               .onDisappear {
                   store.stopListening()
               }
    }
    
//    func loadLogs() {
//        let sharedDefaults = UserDefaults(suiteName: "group.com.company.omnivpn")
//        logs = sharedDefaults?.array(forKey: "logs") as? [String] ?? []
//    }
}
