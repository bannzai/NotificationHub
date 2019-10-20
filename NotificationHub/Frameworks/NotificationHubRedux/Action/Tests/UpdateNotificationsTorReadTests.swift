//
//  UpdateNotificationsTorReadTests.swift
//  NotificationHubTests
//
//  Created by Yudai.Hirose on 2019/10/20.
//  Copyright © 2019 bannzai. All rights reserved.
//

import XCTest
@testable import NotificationHubRedux
import NotificationHubData

class UpdateNotificationsTorReadTests: XCTestCase {

    var sharedStore: Store<AppState>!
    override func setUp() {
        sharedStore = Store<AppState>(
            reducer: appReducer,
            middlewares: [],
            initialState: AppState()
        )
    }

    func testExample() {
        sharedStore.state.notificationPageState.notificationsStatuses[0].notifications = [
            NotificationElement(
                id: "1",
                unread: true,
                subject: Subject(title: "notification title", url: "https://github.com/bannzai"),
                repository: Repository(
                    id: 1,
                    name: "bannzai/NotificationHub",
                    fullName: "bannzai/NotificationHub",
                    repositoryPrivate: false,
                    owner: Owner(
                        id: 10,
                        login: "bannzai",
                        avatarURL: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4"
                    )
                ),
                reason: "Any",
                url: "https://github.com/bannzai",
                updatedAt: "2019-10-20T22:01:45Z"
            )
        ]
        let subject: () -> Int = {
            self.sharedStore.state.notificationPageState.notificationsStatuses.flatMap { $0.visibilyNotifications }.count
        }
        
        XCTAssertEqual(subject(), 1)
        sharedStore.dispatch(action: UpdateNotificationsTorRead(watching: nil, sectionDate: "2019-10-20"))
        XCTAssertEqual(subject(), 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
