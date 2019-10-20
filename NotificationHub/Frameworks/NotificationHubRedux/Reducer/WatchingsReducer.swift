//
//  WatchingListReducer.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubData

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
        state.watchings = [
            ("unkojiki", "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4"),
            ("bannzai", "https://ja.gravatar.com/userimage/115662285/bd8aa2f47f909132bbc70daefcdefb62.png"),
            ("Awesome Project", "https://user-images.githubusercontent.com/10897361/67152615-26a94100-f315-11e9-8e5d-14d51f010f76.png"),
            ("Famous OSS community", "https://user-images.githubusercontent.com/10897361/67152621-3d4f9800-f315-11e9-88b8-5fa03f12e68d.png"),
            ].enumerated().map { (offset, element) in
                WatchingElement(
                    id: Int64(offset),
                    nodeID: "\(offset)",
                    name: "name",
                    fullName: "full name",
                    owner: Owner(id: 10, login: element.0, avatarURL: element.1),
                    notificationsUrl: "https://github.com/\(element.0)"
                )
        }
        state.fetchStatus = .loaded
    case let action as UnSubscribeWatchingAction:
        guard let index = state
            .watchings
            .firstIndex(where: { $0.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        
        state.watchings[index].isReceiveNotification = false
        return state
    case let action as SubscribeWatchingAction:
        guard let index = state
            .watchings
            .firstIndex(where: { $0.owner.login == action.watching.owner.login })
            else {
                fatalError("Unexpected watching \(action.watching)")
        }
        
        state.watchings[index].isReceiveNotification = true
        return state
    case _:
        break
    }
    return state
}
