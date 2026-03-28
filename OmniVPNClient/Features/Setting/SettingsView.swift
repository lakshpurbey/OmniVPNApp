//
//  SettingsView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var config = ConfigManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("MDM Configuration")
                .font(.title)
            
            List {
                ForEach(config.configs.keys.sorted(), id: \.self) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(config.configs[key] ?? "")")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            config.load()
        }
        .padding()
    }
}
