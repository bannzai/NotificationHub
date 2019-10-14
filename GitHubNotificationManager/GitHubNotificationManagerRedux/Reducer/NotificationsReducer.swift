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
        let index = state.currentNotificationPage
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
        return state
    case _:
        return state
    }
}
