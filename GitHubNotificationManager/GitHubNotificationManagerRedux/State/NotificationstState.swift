//
//  NotificationstState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct NotificationstState: ReduxState, Codable {
    enum FetchStatus: Int, Codable {
        case notYetLoad
        case loaded
        case loading
    }
    var notifications: [NotificationElement] = []
    var fetchStatus: FetchStatus = .notYetLoad
}
