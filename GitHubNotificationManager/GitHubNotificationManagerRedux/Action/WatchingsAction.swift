//
//  WatchingListAction.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork
import Combine

struct SetWatchingListAction: Action {
    let elements: [WatchingElement]
}

struct ToggleWatchingAction: Action {
    let watcihng: WatchingElement
}

struct WatchingsFetchAction: AsyncAction {
    var canceller: Canceller

    func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
        if !appState(state).watchingListState.watchings.isEmpty {
            return
        }
        dispatch(NetworkRequestAction.start)

        GitHubAPI
            .request(request: WatchingsRequest())
            .map(SetWatchingListAction.init(elements:))
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
