//
//  NotificationstState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct NotificationPageState: ReduxState, Codable {
    static let allNotificationsState: NotificationsState = NotificationsState(watching: nil)
    static let allNotificationsPage: Int = 0
    var notificationsStatuses: [NotificationsState] = [Self.allNotificationsState]
    var currentNotificationPage: Int = Self.allNotificationsPage
    var currentState: NotificationsState { notificationsStatuses[currentNotificationPage] }
}

struct NotificationsState: ReduxState, Codable {
    enum FetchStatus: Int, Codable {
        case notYetLoad
        case loaded
        case loading
    }
    var watching: WatchingElement?
    var searchWord: String = ""
    var nextFetchPage: Int = 0
    var isVisible: Bool = false
    var notifications: [NotificationElement] = []
    var fetchStatus: FetchStatus = .notYetLoad
}

extension NotificationsState: NotificationPath {
    var notificationPath: URLPathConvertible {
        switch watching {
        case nil:
            return "notifications"
        case let watching?:
            // e.g) https://api.github.com/repos/bannzai/vimrc/notifications{?since,all,participating}
            // Drop {?since, all, participating}
            return watching.notificationsUrl
                .split(separator: "/")
                .reduce(into: "") { (result, element) in
                    switch element {
                    case "/":
                        return
                    case "https:", "api.github.com":
                        return
                    case _:
                        break
                    }
                    
                    switch element.contains("{") {
                    case false:
                        // repos bannzai vimrc
                        result += element + "/"
                    case true:
                        result += element.split(separator: "{").dropLast().joined()
                    }
            }
        }
    }
}
