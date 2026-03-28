//
//  ConnectVPN.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

public struct ConnectVPN {

    private let vpnManager: VPNManaging

    public init(vpnManager: VPNManaging) {
        self.vpnManager = vpnManager
    }

    public func execute() throws {
        try vpnManager.connect()
    }
}
