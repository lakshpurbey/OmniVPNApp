//
//  Untitled.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {

    override func startTunnel(options: [String : NSObject]?,
                              completionHandler: @escaping (Error?) -> Void) {

        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "127.0.0.1")

        settings.ipv4Settings = NEIPv4Settings(
            addresses: ["10.0.0.2"],
            subnetMasks: ["255.255.255.0"]
        )

        setTunnelNetworkSettings(settings) { error in
            completionHandler(error)
        }
    }
}
