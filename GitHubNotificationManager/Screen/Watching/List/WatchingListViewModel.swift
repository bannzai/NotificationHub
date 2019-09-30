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
    func fetch() {
        fetchNext()
    }
    
    func fetchNext() {
        if case .loading = watchingListFetchStatus {
            return
        }
        
        watchingListFetchStatus = .loading
        GitHubAPI
            .request(request: WatchingsRequest())
            .catch { (_) in
                Just([WatchingElement]())
        }
        .handleEvents(receiveOutput: { [weak self] (elements) in
            self?.watchingListFetchStatus = .loaded
        })
            .map { watchings in
                return watchings
                    .map(WatchingModel.create(entity:))
        }
        .sink(receiveValue: { [weak self] (watchings) in
            self?.watchings += watchings
        })
            .store(in: &canceller)
    }
}

extension WatchingListViewModel {
    enum WatchingListFetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
}
