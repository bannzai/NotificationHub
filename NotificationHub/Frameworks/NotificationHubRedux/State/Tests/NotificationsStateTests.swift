//
//  NotificationsStateTests.swift
//  NotificationHubTests
//
//  Created by Yudai.Hirose on 2019/10/20.
//  Copyright © 2019 bannzai. All rights reserved.
//

import XCTest
@testable import NotificationHubRedux
import NotificationHubData

class NotificationsStateTests: XCTestCase {

    func testIsExistsNextPage() {
        XCTContext.runActivity(named: "It has 50 notification.") { (_) in
            let state = NotificationsState(
                watching: nil,
                isVisible: true,
                notifications: (0..<NotificationsRequest.elementPerPage).map { offset in
                    NotificationElement(
                        id: "\(offset)",
                        unread: true,
                        subject: Subject(
                            title: "bannzai/NotificationHub",
                            url: "https://github.com/bannzai"
                        ),
                        repository: Repository(
                            id: offset,
                            name: "conv",
                            fullName: "bannzai/conv",
                            repositoryPrivate: false,
                            owner: Owner(id: offset, login: "bannzai", avatarURL: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4")
                        ),
                        reason: "Any",
                        url: "https://github.com/bannzai",
                        updatedAt: "2014-11-07T22:01:45Z"
                    )
                }
            )
            XCTAssertEqual(state.notifications.count, NotificationsRequest.elementPerPage)
            XCTAssertEqual(state.notifications.count, 50)
            XCTAssertEqual(state.isExistsNextPage, true)
        }
        XCTContext.runActivity(named: "It has 49 notification.") { (_) in
            let state = NotificationsState(
                watching: nil,
                isVisible: true,
                notifications: (0..<NotificationsRequest.elementPerPage - 1).map { offset in
                    NotificationElement(
                        id: "\(offset)",
                        unread: true,
                        subject: Subject(
                            title: "bannzai/NotificationHub",
                            url: "https://github.com/bannzai"
                        ),
                        repository: Repository(
                            id: offset,
                            name: "conv",
                            fullName: "bannzai/conv",
                            repositoryPrivate: false,
                            owner: Owner(id: offset, login: "bannzai", avatarURL: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4")
                        ),
                        reason: "Any",
                        url: "https://github.com/bannzai",
                        updatedAt: "2014-11-07T22:01:45Z"
                    )
                }
            )
            XCTAssertNotEqual(state.notifications.count, NotificationsRequest.elementPerPage)
            XCTAssertEqual(state.notifications.count, 49)
            XCTAssertEqual(state.isExistsNextPage, false)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
