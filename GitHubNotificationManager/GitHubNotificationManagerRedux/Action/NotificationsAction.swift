//
//  NotificationsAction.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork
import Combine

struct CreateNotificationsAction: Action {
    let watching: WatchingElement
}
struct AddNotificationListAction: Action {
    let elements: [NotificationElement]
}

struct ChangeNotificationPageAction: Action {
    let page: Int
}

struct SearchRequestAction: Action {
    let text: String
}

struct UnReadNotificationAction: Action {
    let notification: NotificationElement
    let unread: Bool
}

struct NotificationsFetchAction: AsyncAction {
    let watching: WatchingElement?
    var canceller: Canceller

    func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
        let state = appState(state).notificationPageState.notificationsStatuses.first(where: { $0.watching?.owner.login == watching?.owner.login })!
        dispatch(NetworkRequestAction.start)
        GitHubAPI
            .request(request: NotificationsRequest(page: state.nextFetchPage, notificationsUrl: state))
            .map(AddNotificationListAction.init(elements:))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    dispatch(ReceiveNetworkRequestError.init(error: error))
                }
                dispatch(NetworkRequestAction.finished)
            }, receiveValue: { values in
                dispatch(values)
            })
            .store(in: &canceller.canceller)
    }
}
