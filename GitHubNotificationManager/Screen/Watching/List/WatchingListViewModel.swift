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
import GitHubWatchingManagerNetwork

final public class WatchingListViewModel: ObservableObject {
    private var canceller: Set<AnyCancellable> = []
    
    @Published private var allWatchings: [WatchingModel] = []
    @Published internal var searchWord: String = ""
    
    private var filteredWatchings: [WatchingModel] {
        allWatchings.filter { $0.match(for: searchWord) }
    }
    
    internal var Watchings: [WatchingModel] {
        searchWord.isEmpty ? allWatchings : filteredWatchings
    }
    
    private var WatchingListFetchStatus: WatchingListFetchStatus = .notYetLoad
}

internal extension WatchingListViewModel {
    func fetch() {
        fetchNext()
    }
    
    func fetchNext() {
        if case .loading = WatchingListFetchStatus {
            return
        }
        
        WatchingListFetchStatus = .loading
        GitHubAPI
            .request(request: WatchingsRequest(page: allWatchings.count / WatchingsRequest.perPage))
            .catch { (_) in
                Just([WatchingElement]())
        }
        .handleEvents(receiveOutput: { [weak self] (elements) in
            self?.WatchingListFetchStatus = .loaded
        })
            .map { Watchings in
                return Watchings
                    .filter { !$0.repository.repositoryPrivate }
                    .map(WatchingModel.create(entity:))
        }
        .sink(receiveValue: { [weak self] (Watchings) in
            self?.allWatchings += Watchings
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
