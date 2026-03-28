//
//  PolicyEngineTests.swift
//  OmniVPNClient
//
//  Created by Laksh Purbey on 27/03/26.
//

import XCTest
@testable import Domain

final class PolicyEngineTests: XCTestCase {

    func testPacketAllowed() {
        let engine = PolicyEngine()
        XCTAssertTrue(engine.evaluate(packet: Data()))
    }
}
