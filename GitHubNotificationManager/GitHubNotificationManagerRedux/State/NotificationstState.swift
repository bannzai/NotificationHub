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
    var groupedNotifications: [GroupedNotification] {
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
    }
    var visibilyNotifications: [NotificationElement] {
        notifications.filter { !$0.unread }
    }
    var notifications: [NotificationElement] = []
}

let originalDateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
let sectionDateFormat = "yyyy-MM-dd"
extension Array where Element == NotificationElement {
    private func dateComponents(from key: String, format: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        guard let date = dateFormatter.date(from: key) else {
            fatalError("unexpected date format \(key)")
        }
        let components = Calendar(identifier: .gregorian).dateComponents(in: TimeZone.current, from: date)
        return components
    }
    
    func indicies(key: String) -> [Array<Element>.Index] {
        let keyDate = dateComponents(from: key, format: sectionDateFormat)
        return map { dateComponents(from: $0.updatedAt, format: originalDateFormat) }
            .enumerated()
            .filter { $0.element.year == keyDate.year && $0.element.month == keyDate.month && $0.element.day == keyDate.day }
            .map { $0.offset }
    }
}

struct GroupedNotification: Equatable, Codable {
    typealias NotificationDate = String
    let key: NotificationDate
    var values: [NotificationElement]
    
    static func toKey(dateString: String) -> NotificationDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originalDateFormat
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("unexpected date format \(dateString)")
        }
        
        dateFormatter.dateFormat = sectionDateFormat
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
