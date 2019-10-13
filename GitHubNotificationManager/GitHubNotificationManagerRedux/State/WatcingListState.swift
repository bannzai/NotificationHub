//
//  WatcingListState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

struct WatchingListState: ReduxState {
    enum FetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
    var watchings: [WatchingEntity] = []
    var fetchStatus: FetchStatus = .notYetLoad
}
