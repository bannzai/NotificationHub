//
//  WatchingListAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubNetwork
import Combine

struct SetWatchingListAction: Action {
    let elements: [WatchingElement]
}

struct SubscribeWatchingAction: Action {
    let watching: WatchingElement
}

struct UnSubscribeWatchingAction: Action {
    let watching: WatchingElement
}

struct WatchingsFetchAction: AsyncAction {
    var canceller: Canceller

    func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
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
