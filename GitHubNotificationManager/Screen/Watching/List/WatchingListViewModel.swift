//
//  WatchingListViewModel.swift
//  GitHubWatchingManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GitHubNotificationManagerNetwork

final public class WatchingListViewModel: ObservableObject {
    private var canceller: Set<AnyCancellable> = []
    
    @Published var watchings: [WatchingModel] = []

    private var watchingListFetchStatus: WatchingListFetchStatus = .notYetLoad
}

internal extension WatchingListViewModel {
    private func distinct(watchings: [WatchingModel]) -> [WatchingModel] {
        watchings.reduce(into: [WatchingModel]()) { (result, element) in
            switch result.contains(where: { $0.owner.name == element.owner.name }) {
            case true:
                return
            case false:
                result.append(element)
            }
        }
    }
    
    func fetchFirst() {
        guard case .notYetLoad = watchingListFetchStatus else {
            return
        }

        watchingListFetchStatus = .loading
        GitHubAPI
            .request(request: WatchingsRequest())
            .catch { (error) in
                Just([WatchingElement]())
        }
        .handleEvents(receiveOutput: { [weak self] (elements) in
            self?.watchingListFetchStatus = .loaded
        }).map { watchings in
            // TODO: fetch isReceiveNotification
            return watchings
                .map { WatchingModel.create(entity: $0, isReceiveNotification: false) }
        }.sink(receiveValue: { [weak self] (watchings) in
            guard let self = self else {
                return
            }
            self.watchings += self.distinct(watchings: watchings)
        }).store(in: &canceller)
    }
}

extension WatchingListViewModel {
    enum WatchingListFetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
}
