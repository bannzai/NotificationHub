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
        state.watchings = state.watchings.reduce(into: action.elements.distinct(), { (result, element) in
            result.firstIndex(where: { $0.owner.login == element.owner.login }).map {
                result[$0].isReceiveNotification = element.isReceiveNotification
            }
        })
        state.fetchStatus = .loaded
    case let action as UnSubscribeWatchingAction:
        guard let index = state
            .watchings
            .firstIndex(where: { $0.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        
        state.watchings[index].isReceiveNotification = false
        print("watchings UnSubscribeWatchingAction: \(state.watchings[index].isReceiveNotification)")
        return state
    case let action as SubscribeWatchingAction:
        guard let index = state
            .watchings
            .firstIndex(where: { $0.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        
        state.watchings[index].isReceiveNotification = true
        print("watchings SubscribeWatchingAction: \(state.watchings[index].isReceiveNotification)")
        return state
    case _:
        break
    }
    return state
}
