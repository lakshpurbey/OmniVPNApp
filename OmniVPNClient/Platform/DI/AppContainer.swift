//
//  AppContainer.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

final class AppContainer {

    static let shared = AppContainer()

    lazy var vpnManager: VPNManaging = VPNManager()

    lazy var connectVPN = ConnectVPN(vpnManager: vpnManager)
}
