//
//  HomeStateTests.swift
//  SwiftDemoTests
//
//  Created by djiang on 29/11/21.
//

import Foundation
import XCTest
@testable import SwiftDemo

class HomeStateTests: XCTestCase {
    var sut: HomeState!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeState()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAppModel_whenInitialized() {
        let initialState = sut
        XCTAssertEqual(initialState, HomeState())
    }
}
