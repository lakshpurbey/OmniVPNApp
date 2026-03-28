//
//  VPNManager.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import NetworkExtension

final class VPNManager: VPNManaging {

    func connect() throws {
        try NEVPNManager.shared().connection.startVPNTunnel()
    }

    func disconnect() {
        NEVPNManager.shared().connection.stopVPNTunnel()
    }
}
