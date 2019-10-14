//
//  WatchingsState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct WatchingsState: ReduxState, Codable, Equatable {
    enum FetchStatus: Int, Codable, Equatable {
        case notYetLoad
        case loaded
        case loading
    }
    var watchings: [WatchingElement] = []
    var fetchStatus: FetchStatus = .notYetLoad
}
