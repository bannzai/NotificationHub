//
//  WatchingListAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore
import Combine

public struct SetWatchingListAction: Action {
    let elements: [WatchingElement]

// sourcery:inline:auto:SetWatchingListAction.AutoInitAction:
    public init(
        elements: [WatchingElement]
        ) {
        self.elements = elements
    }
// sourcery:end
}

public struct SubscribeWatchingAction: Action {
    let watching: WatchingElement

// sourcery:inline:auto:SubscribeWatchingAction.AutoInitAction:
    public init(
        watching: WatchingElement
        ) {
        self.watching = watching
    }
// sourcery:end
}

public struct UnSubscribeWatchingAction: Action {
    let watching: WatchingElement

// sourcery:inline:auto:UnSubscribeWatchingAction.AutoInitAction:
    public init(
        watching: WatchingElement
        ) {
        self.watching = watching
    }
// sourcery:end
}

public struct WatchingsFetchAction: AsyncAction {
    var canceller: Canceller

    public func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
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

// sourcery:inline:auto:WatchingsFetchAction.AutoInitAction:
    public init(
        canceller: Canceller
        ) {
        self.canceller = canceller
    }
// sourcery:end
}
