//
//  VPNProtocol.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

public protocol VPNManaging {
    func connect() throws
    func disconnect()
}
