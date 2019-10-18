//
//  ToggleWatchingTests.swift
//  NotificationHubTests
//
//  Created by Yudai Hirose on 2019/10/14.
//  Copyright © 2019 bannzai. All rights reserved.
//

import XCTest
@testable import NotificationHubRedux
import NotificationHubNetwork

class ToggleWatchingTests: XCTestCase {

    var sharedStore: Store<AppState>!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sharedStore = Store<AppState>(
            reducer: appReducer,
            middlewares: [
                asyncActionsMiddleware,
                signupMiddleware,
            ],
            initialState: AppState()
        )
    }

    func testPaging() {
        let watchings: [WatchingElement] = ["bannzai", "hoge", "fuga", "piyo"]
            .enumerated()
            .map { (arg) -> WatchingElement in
                let (offset, element) = arg
                return WatchingElement(
                    id: Int64(offset),
                    nodeID: "\(offset)",
                    name: "name",
                    fullName: "full name",
                    owner: Owner(id: 10, login: element, avatarURL: Debug.Const.avatarURL),
                    notificationsUrl: "https://github.com/\(element)"
            )
        }
        sharedStore.dispatch(action: SetWatchingListAction(elements: watchings))
        watchings.forEach { watching in
            sharedStore.dispatch(action: CreateNotificationsAction(watching: watching))
            sharedStore.dispatch(action: SubscribeWatchingAction(watching: watching))
        }
        XCTAssertEqual(sharedStore.state.notificationPageState.notificationsStatuses.filter { $0.isVisible }.count, 5)
        
        watchings.forEach { watching in
            sharedStore.dispatch(action: UnSubscribeWatchingAction(watching: watching))
        }
        XCTAssertEqual(sharedStore.state.notificationPageState.notificationsStatuses.filter { $0.isVisible }.count, 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
