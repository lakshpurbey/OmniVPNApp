//
//  SettingsView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var config = ConfigManager.shared
    
    var body: some View {
        List {
            
            // Header Section
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Omni VPN")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Managed Configuration")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            
            // Config Section
            Section(header: Text("Configuration")) {
                
                if config.configs.isEmpty {
                    HStack {
                        Spacer()
                        Text("No configuration available")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Spacer()
                    }
                } else {
                    ForEach(config.configs.keys.sorted(), id: \.self) { key in
                        settingRow(key: key, value: config.configs[key])
                    }
                }
            }
        }
#if os(iOS)
        .listStyle(.insetGrouped)
#elseif os(macOS)
        .listStyle(.inset)
#else
        .listStyle(.automatic)
#endif // platform list style
        .navigationTitle("Settings")
        .onAppear {
            config.load()
        }
    }
    
    func settingRow(key: String, value: Any?) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(key)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(formattedValue(value))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.vertical, 6)
    }
    
    func formattedValue(_ value: Any?) -> String {
        switch value {
        case let bool as Bool:
            return bool ? "Enabled" : "Disabled"
        case let number as NSNumber:
            return "\(number)"
        case let string as String:
            return string
        case nil:
            return "—"
        default:
            return String(describing: value!)
        }
    }
}

