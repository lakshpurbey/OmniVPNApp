//
//  DashboardViewModel.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import SwiftUI
import Combine

final class DashboardViewModel: ObservableObject {

    @Published var isConnected = false
    
    // Dynamic Stats
    @Published var latency: String = "--"
    @Published var traffic: String = "--"
    @Published var uptime: String = "--"
    
    private var timer: Timer?
    private var seconds = 0
    
    @Published var trafficData: [TrafficData] = []
    private let maxDataPoints = 20

    var statusText: String {
        isConnected ? "Connected" : "Disconnected"
    }

    func toggleVPN() {
        let useCase = AppContainer.shared.connectVPN

        if isConnected {
            AppContainer.shared.vpnManager.disconnect()
            stopStats()
        } else {
            try? useCase.execute()
            startStats()
        }

        isConnected.toggle()
    }
    
}

extension DashboardViewModel {
    
    // MARK: - Start Stats
    private func startStats() {
        generateInitialStats()
        startUptimeTimer()
        startTrafficSimulation()
    }
    
    // MARK: - Stop Stats
    private func stopStats() {
        timer?.invalidate()
        latency = "--"
        traffic = "--"
        uptime = "--"
        seconds = 0
    }
    
    // MARK: - Initial Values
    private func generateInitialStats() {
        latency = "\(Int.random(in: 20...60)) ms"
        traffic = "0 MB"
        uptime = "0s"
    }
    
    // MARK: - Uptime Timer
    private func startUptimeTimer() {
        seconds = 0
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.seconds += 1
            self.uptime = "\(self.seconds)s"
        }
    }
    
    // MARK: - Traffic Simulation (every 2 sec)
    private func startTrafficSimulation() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            guard self.isConnected else {
                timer.invalidate()
                return
            }
            
            let current = Int(self.traffic.replacingOccurrences(of: " MB", with: "")) ?? 0
            let newValue = current + Int.random(in: 5...20)
            self.traffic = "\(newValue) MB"
        }
    }
}

// MARK: - Graph Logic
extension DashboardViewModel {
    
    /// Start generating traffic data (simulate real-time updates)
    func startGraphUpdates() {
        stopGraphUpdates() // prevent duplicate timers
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let newPoint = TrafficData(
                time: Date(),
                value: Int.random(in: 10...100)
            )
            
            DispatchQueue.main.async {
                self.trafficData.append(newPoint)
                
                // Keep only last N points (sliding window)
                if self.trafficData.count > self.maxDataPoints {
                    self.trafficData.removeFirst()
                }
            }
        }
    }
    
    /// Stop updates when VPN disconnects
    func stopGraphUpdates() {
        timer?.invalidate()
        timer = nil
        trafficData.removeAll()
    }
}
