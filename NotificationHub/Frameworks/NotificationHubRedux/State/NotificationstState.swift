//
//  NotificationstState.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore
import NotificationHubData

public struct NotificationPageState: ReduxState, Codable, Equatable {
    static let allNotificationsState: NotificationsState = NotificationsState(watching: nil, isVisible: true)
    static let allNotificationsPage: Int = 0
    public var notificationsStatuses: [NotificationsState] = [Self.allNotificationsState]
    public var currentNotificationPage: Int = Self.allNotificationsPage
    var currentState: NotificationsState { notificationsStatuses.filter { $0.isVisible }[currentNotificationPage] }
}

public struct NotificationsState: ReduxState, Codable, Equatable {
    public enum FetchStatus: Int, Codable, Equatable {
        case notYetLoad
        case loaded
    }

    public var watching: WatchingElement?
    public var fetchStatus: FetchStatus = .notYetLoad
    public var nextFetchPage: Int { (notifications.count + NotificationsRequest.elementPerPage) / NotificationsRequest.elementPerPage - 1 }
    public internal(set) var isVisible: Bool = false
    public var groupedNotifications: [GroupedNotification] {
        visibilyNotifications.reduce(into: [GroupedNotification]()) { (result, element) in
            let key = GroupedNotification.toKey(dateString: element.updatedAt)
            let matcher: (GroupedNotification) -> Bool = {
                $0.key == key
            }
            switch result.contains(where: matcher) {
            case true:
                let index = result.firstIndex(where: matcher)!
                result[index].values.append(element)
            case false:
                result.append(GroupedNotification(key: key, values: [element]))
            }
        }
        .sorted { $0.key > $1.key }
    }
    public var visibilyNotifications: [NotificationElement] {
        notifications
    }
    var notifications: [NotificationElement] = []
}

extension Array where Element == NotificationElement {
    func indicies(key: String) -> [Array<Element>.Index] {
        let keyDate = SectionTitleDateFormatter.dateComponents(from: key)
        return map { APIDateformatter.dateComponents(from: $0.updatedAt) }
            .enumerated()
            .filter { $0.element.year == keyDate.year && $0.element.month == keyDate.month && $0.element.day == keyDate.day }
            .map { $0.offset }
    }
}

public struct GroupedNotification: Equatable, Codable, Identifiable {
    public typealias NotificationDate = String
    public var id: String { key }
    public let key: NotificationDate
    public internal(set) var values: [NotificationElement]
    
    public init(key: NotificationDate, values: [NotificationElement]) {
        self.key = key
        self.values = values
    }
    
    static func toKey(dateString: String) -> NotificationDate {
        let date = APIDateformatter.date(from: dateString)
        let string = SectionTitleDateFormatter.string(from: date)
        return string
    }
}

extension NotificationsState: NotificationPath {
    public var notificationPath: URLPathConvertible {
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
