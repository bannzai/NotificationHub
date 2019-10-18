//
//  WatchingsState.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

public struct WatchingsState: ReduxState, Codable, Equatable {
    enum FetchStatus: Int, Codable, Equatable {
        case notYetLoad
        case loaded
    }
    var watchings: [WatchingElement] = []
    var fetchStatus: FetchStatus = .notYetLoad
}
