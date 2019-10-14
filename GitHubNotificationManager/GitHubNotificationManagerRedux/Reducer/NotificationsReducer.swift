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
        notificationsState.notifications += action.elements
        notificationsState.fetchStatus = .loaded
        var state = state
        state.notificationsStatuses[index] = notificationsState
        return state
    case let action as ChangeNotificationPageAction:
        var state = state
        state.currentNotificationPage = action.page
        return state
    case let action as SearchRequestAction:
        var state = state
        var notificationsState = state.currentState
        notificationsState.searchWord = action.text
        state.notificationsStatuses[state.currentNotificationPage] = notificationsState
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
        guard
            let pageIndex = state.notificationsStatuses.firstIndex(where: { $0.notifications.map { $0.id }.contains(action.notificationId) }),
            let notificationIndex = state.notificationsStatuses[pageIndex].notifications.map({ $0.id }).firstIndex(of: action.notificationId)
            else {
                fatalError("Unexpected notification for \(action.notificationId)")
        }
        var state = state
        state.notificationsStatuses[pageIndex].notifications[notificationIndex].unread = true
        return state
    case let action as ReadNotificationAction:
        guard
            let pageIndex = state.notificationsStatuses.firstIndex(where: { $0.notifications.map { $0.id }.contains(action.notificationId) }),
            let notificationIndex = state.notificationsStatuses[pageIndex].notifications.map({ $0.id }).firstIndex(of: action.notificationId)
        else {
            fatalError("Unexpected notification for \(action.notificationId)")
        }
        var state = state
        state.notificationsStatuses[pageIndex].notifications[notificationIndex].unread = false
        return state
    case _:
        return state
    }
}
