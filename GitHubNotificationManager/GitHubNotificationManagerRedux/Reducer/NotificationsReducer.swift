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
    case let action as CreateNotifications:
        switch state.notificationsStatuses.contains(where: { $0.watching?.id == action.watching.id }) {
        case false:
            var state = state
            state.notificationsStatuses.append(NotificationsState(watching: action.watching))
            return state
        case true:
            return state
        }
    case let action as SetNotificationList:
        let index = state.currentNotificationPage
        var notificationsState = state.notificationsStatuses[index]
        notificationsState.notifications = action.elements
        notificationsState.nextFetchPage += 1
        var state = state
        state.notificationsStatuses[index] = notificationsState
        return state
    case let action as ChangeNotificationPage:
        var state = state
        state.currentNotificationPage = action.page
        return state
    case let action as NetworkRequestAction:
        var notificationsState = state.currentState
        switch action {
        case .start:
            notificationsState.fetchStatus = .loading
        case .finished:
            notificationsState.fetchStatus = .loaded
        }
        var state = state
        state.notificationsStatuses[state.currentNotificationPage] = notificationsState
        return state
    case _:
        return state
    }
}
