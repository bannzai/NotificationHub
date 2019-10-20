//
//  NotificationsReducer.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubData

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
        (1...10).forEach { _ in
            notificationsState.notifications += [
                (repo: "fake/info", desc: "There are dummy data", avatar: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4"),
                (repo: "username/reponame", desc: "When tap cell, You can confrim action for your watching repository", avatar: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4"),
            (repo: "unkojiki/NotificationHub", desc: "Prepare for Appstore connect", avatar: "https://ja.gravatar.com/userimage/115662285/bd8aa2f47f909132bbc70daefcdefb62.png"),
            (repo: "Awesome Project/Ocha", desc: "Bugfix unable load file", avatar: "https://user-images.githubusercontent.com/10897361/67152615-26a94100-f315-11e9-8e5d-14d51f010f76.png"),
            (repo: "Famous OSS community/Conv", desc: "Completion decided of syntax sugar", avatar: "https://user-images.githubusercontent.com/10897361/67152621-3d4f9800-f315-11e9-88b8-5fa03f12e68d.png"),
            (repo: "bannzai/ResourceKit", desc: "Adapt for Swift package manager", avatar: "https://ja.gravatar.com/userimage/115662285/bd8aa2f47f909132bbc70daefcdefb62.png"),
            (repo: "bannzai/notifier", desc: "First release!!", avatar: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4"),
            ]
            .enumerated()
            .map { (offset, element) in
                NotificationElement(
                    id: "\(offset)",
                    unread: true,
                    subject: Subject(title: element.desc, url: ""),
                    repository: Repository(id: offset, name: element.repo, fullName: element.repo, repositoryPrivate: false, owner: Owner(id: offset, login: element.repo, avatarURL: element.avatar)),
                    reason: "",
                    url: "",
                    updatedAt: "2014-11-07T22:01:45Z"
                )
            }
        }
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
    case let action as UpdateNotificationsTorRead:
        guard let pageIndex = state.notificationsStatuses.firstIndex(where: { $0.watching?.owner.login == action.watching?.owner.login }) else {
            fatalError("Unexpected target watching \(String(describing: action.watching))")
        }
        
        var state = state
        let indicies = state.notificationsStatuses[pageIndex].notifications.indicies(key: action.sectionDate)
        indicies.forEach {
            state.notificationsStatuses[pageIndex].notifications[$0].unread = true
        }
        return state
    case let action as RestoreAction:
        var state = state
         action
            .watching
            .watchings
            .filter { $0.isReceiveNotification }
            .forEach { state.notificationsStatuses.append(NotificationsState(watching: $0, isVisible: true)) }
        return state
    case _:
        return state
    }
}
