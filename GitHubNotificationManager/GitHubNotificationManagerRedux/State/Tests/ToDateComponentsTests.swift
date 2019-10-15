//
//  ToDateComponentsTests.swift
//  GitHubNotificationManagerTests
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import XCTest
@testable import NotificationHub

class ToDateComponentsTests: XCTestCase {
    func testToDateComponents() {
        XCTContext.runActivity(named: "yyyy-MM-dd'T'hh:mm:ss'Z' format") { (_) in
            let dateComponents = toDateComponents(from: "2014-11-07T22:01:45Z", format: "yyyy-MM-dd'T'hh:mm:ss'Z'")
            XCTAssertEqual(dateComponents.year, 2014)
            XCTAssertEqual(dateComponents.month, 11)
            XCTAssertEqual(dateComponents.day, 7)
        }
        XCTContext.runActivity(named: "yyyy-MM-dd'T'hh:mm:ss'Z' format") { (_) in
            let dateComponents = toDateComponents(from: "2015-12-10", format: "yyyy-MM-dd")
            XCTAssertEqual(dateComponents.year, 2015)
            XCTAssertEqual(dateComponents.month, 12)
            XCTAssertEqual(dateComponents.day, 10)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
