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
struct SetNotificationListAction: Action {
    let elements: [NotificationElement]
}

struct ChangeNotificationPageAction: Action {
    let page: Int
}

struct SearchRequestAction: Action {
    let text: String
}

struct NotificationsFetchAction: AsyncAction {
    var canceller: Canceller
    var watchingId: WatchingElement.ID?
    
    func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
        dispatch(NetworkRequestAction.start)
        
        let state = appState(state).notificationPageState.currentState
        GitHubAPI
            .request(request: NotificationsRequest(page: state.nextFetchPage, notificationsUrl: state))
            .map(SetNotificationListAction.init(elements:))
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
