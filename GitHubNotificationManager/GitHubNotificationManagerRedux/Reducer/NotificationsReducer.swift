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
        switch state.notificationsStatuses.contains(where: { $0.watching?.id == action.watching.id }) {
        case false:
            var state = state
            state.notificationsStatuses.append(NotificationsState(watching: action.watching))
            return state
        case true:
            return state
        }
    case let action as SetNotificationListAction:
        let index = state.currentNotificationPage
        var notificationsState = state.notificationsStatuses[index]
        notificationsState.notifications = action.elements
        notificationsState.nextFetchPage += 1
        var state = state
        state.notificationsStatuses[index] = notificationsState
        return state
    case let action as ChangeNotificationPageAction:
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
    case let action as SearchRequestAction:
        var state = state
        var notificationsState = state.currentState
        notificationsState.searchWord = action.text
        state.notificationsStatuses[state.currentNotificationPage] = notificationsState
        return state
    case let action as ToggleWatchingAction:
        var state = state
        guard let index = state.notificationsStatuses.firstIndex(where: { $0.watching?.id == action.watcihng.id }) else {
            fatalError("Unexpected watching \(action.watcihng)")
        }
        state.notificationsStatuses[index].isVisible.toggle()
        return state
    case _:
        return state
    }
}
