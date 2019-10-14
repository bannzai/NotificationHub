//
//  NotificationsReducer.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

let notificationsReducer: Reducer<NotificationPageState> = { state, action in
    switch action {
    case let action as CreateNotificationsAction:
        switch state.notificationsStatuses.contains(where: { $0.watching?.owner.login == action.watching.owner.login }) {
        case false:
            var state = state
            state.notificationsStatuses.append(NotificationsState(watching: action.watching, isVisible: true))
            return state
        case true:
            return state
        }
    case let action as AddNotificationListAction:
        guard let index = state.notificationsStatuses.firstIndex(where: { $0.watching?.owner.login == action.watching?.owner.login }) else {
            fatalError("Unexpected watching :\(String(describing: action.watching))")
        }
        var notificationsState = state.notificationsStatuses[index]
        notificationsState.groupedNotifications = action.elements.reduce(into: notificationsState.groupedNotifications, { (result, element) in
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
        })
        notificationsState.fetchStatus = .loaded
        var state = state
        state.notificationsStatuses[index] = notificationsState
        return state
    case let action as ChangeNotificationPageAction:
        var state = state
        state.currentNotificationPage = action.page
        return state
    case let action as UnSubscribeWatchingAction:
        guard let index = state
            .notificationsStatuses
            .firstIndex(where: { $0.watching?.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        var state = state
        state.notificationsStatuses[index].isVisible = false
        print("notification UnSubscribeWatchingAction: \(state.notificationsStatuses[index].isVisible)")
        return state
    case let action as SubscribeWatchingAction:
        guard let index = state
            .notificationsStatuses
            .firstIndex(where: { $0.watching?.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        var state = state
        state.notificationsStatuses[index].isVisible = true
        print("notification SubscribeWatchingAction: \(state.notificationsStatuses[index].isVisible)")
        return state
    case let action as UnReadNotificationAction:
        var state = state
        let (pageIndex, groupedIndex, notificationIndex) = state.indexesOf(notificationId: action.notificationId)
        state.notificationsStatuses[pageIndex].groupedNotifications[groupedIndex].values[notificationIndex].unread = false
        return state
    case let action as ReadNotificationAction:
        var state = state
        let (pageIndex, groupedIndex, notificationIndex) = state.indexesOf(notificationId: action.notificationId)
        state.notificationsStatuses[pageIndex].groupedNotifications[groupedIndex].values[notificationIndex].unread = true
        return state
    case _:
        return state
    }
}
