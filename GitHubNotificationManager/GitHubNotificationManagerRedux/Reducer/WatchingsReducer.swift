//
//  WatchingListReducer.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

extension Array where Element == WatchingElement {
    func distinct() -> [WatchingElement] {
        reduce(into: [WatchingElement]()) { (result, element) in
            switch result.contains(where: { $0.owner.login == element.owner.login }) {
            case true:
                return
            case false:
                result.append(element)
            }
        }
    }
}


let watchingsReducer: Reducer<WatchingsState> = { state, action in
    var state = state
    switch action {
    case let action as SetWatchingListAction:
        state.watchings = action.elements.distinct()
    case let action as ToggleWatchingAction:
        guard let index = state
            .watchings
            .firstIndex(where: { $0.id == action.watcihng.id })
            else {
                fatalError("Unexpected watching \(action.watcihng)")
        }
        
        state.watchings[index].isReceiveNotification.toggle()
        return state
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
