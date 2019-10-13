//
//  WatchingListReducer.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

let watchingsReducer: Reducer<WatchingsState> = { state, action in
    var state = state
    switch action {
    case let action as SetWatchingList:
        state.watchings = action.elements
    case let action as NetworkRequestAction:
        switch action {
        case .start:
            state.fetchStatus = .loading
        case .finished:
            state.fetchStatus = .loaded
        }
    case _:
        break
    }
    return state
}
