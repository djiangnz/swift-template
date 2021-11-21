//
//  SwiftDemoTests.swift
//  SwiftDemoTests
//
//  Created by djiang on 10/10/21.
//

import XCTest
import Utils
import Models

@testable import SwiftDemo
import SnapshotTesting

class SwiftDemoTests: XCTestCase {
    let userList: UserList = Bundle.JSONParser("UserList.json", in: Bundle.Tests)
    var viewController: UIViewController!
    var isRecord: Bool!

    override func setUpWithError() throws {
        try super.setUpWithError()
        isRecord = false
        viewController = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel()))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewController = nil
    }

    func testExample() throws {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.backgroundColor = .red
        label.text = "example"
        viewController.view.addSubview(label)
        assertSnapshot(matching: viewController, as: .wait(for: 0.1, on: .image(on: .iPhoneSe)), record: isRecord)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
