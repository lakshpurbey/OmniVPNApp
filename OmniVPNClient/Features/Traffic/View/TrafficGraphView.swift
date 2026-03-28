//
//  TrafficGraphView.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 28/03/26.
//

import Charts
import SwiftUI

struct TrafficGraphView: View {
    
    var data: [TrafficData]
    
    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Time", $0.time),
                y: .value("Traffic", $0.value)
            )
        }
        .frame(height: 200)
    }
}
