//
//  NotificationstState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct NotificationPageState: ReduxState, Codable, Equatable {
    static let allNotificationsState: NotificationsState = NotificationsState(watching: nil, isVisible: true)
    static let allNotificationsPage: Int = 0
    var notificationsStatuses: [NotificationsState] = [Self.allNotificationsState]
    var currentNotificationPage: Int = Self.allNotificationsPage
    var currentState: NotificationsState { notificationsStatuses.filter { $0.isVisible }[currentNotificationPage] }
    
    func indexesOf(notificationId: NotificationElement.ID) -> (pageIndex: Int, groupedNotificationIndex: Int, notificationIndex: Int) {
        let groupedNotificationMatcher: ([GroupedNotification]) -> Bool = { groupedNotifications in
            groupedNotifications.contains(where: { $0.values.contains { $0.id == notificationId }})
        }
        let notificationsMatcher: ([NotificationElement]) -> Bool = { notifications in
            notifications.contains(where: { $0.id == notificationId })
        }
        guard
            let pageIndex = notificationsStatuses.firstIndex(where: { groupedNotificationMatcher($0.groupedNotifications) }),
            let groupedNotificationIndex = notificationsStatuses
                .first(where: { groupedNotificationMatcher($0.groupedNotifications) })?
                .groupedNotifications
                .firstIndex(where: { notificationsMatcher($0.values) }),
            let notificationIndex = notificationsStatuses
                .first(where: { groupedNotificationMatcher($0.groupedNotifications) })?
                .groupedNotifications
                .first(where: { notificationsMatcher($0.values) })?
                .values
                .firstIndex(where: { $0.id == notificationId })
            else {
                fatalError("Unexpected notification id \(notificationId)")
        }
        return (pageIndex: pageIndex, groupedNotificationIndex: groupedNotificationIndex, notificationIndex: notificationIndex)
    }
}

struct NotificationsState: ReduxState, Codable, Equatable {
    enum FetchStatus: Int, Codable, Equatable {
        case notYetLoad
        case loaded
        case loading
    }

    var watching: WatchingElement?
    var fetchStatus: FetchStatus = .notYetLoad
    var nextFetchPage: Int { (notifications.count + NotificationsRequest.elementPerPage) / NotificationsRequest.elementPerPage - 1 }
    var isVisible: Bool = false
    var groupedNotifications: [GroupedNotification] = []
    var notifications: [NotificationElement] {
        groupedNotifications.flatMap { $0.values }
    }
}

struct GroupedNotification: Equatable, Codable {
    typealias NotificationDate = String
    let key: NotificationDate
    var values: [NotificationElement]
    
    static func toKey(dateString: String) -> NotificationDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("unexpected date format \(dateString)")
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: date)
        return string
    }
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
