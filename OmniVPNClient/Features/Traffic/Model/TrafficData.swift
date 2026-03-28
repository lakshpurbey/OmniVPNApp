//
//  TrafficData.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Foundation

struct TrafficData: Identifiable {
    let id = UUID()
    let time: Date
    let value: Int
}
