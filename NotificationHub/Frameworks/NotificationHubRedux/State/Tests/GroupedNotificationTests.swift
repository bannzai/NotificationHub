//
//  GroupedNotificationTests.swift
//  NotificationHubTests
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import XCTest
@testable import NotificationHubRedux

class GroupedNotificationTests: XCTestCase {

    func testToKey() {
        XCTAssertEqual(GroupedNotification.toKey(dateString: "2014-11-07T22:01:45Z"), "2014-11-07")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
