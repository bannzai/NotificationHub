//
//  RootViewModel.swift
//  GitHubWatchingManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GitHubNotificationManagerNetwork

final public class RootViewModel: ObservableObject {
    private var canceller: Set<AnyCancellable> = []
    
    @Published var watchings: [WatchingModel] = []
    @Published var githubAccessToken: String? = UserDefaults.standard.string(forKey: .GitHubAccessToken) {
        didSet {
            NetworkConfig.Github.accessToken = githubAccessToken
            UserDefaults.standard.set(githubAccessToken, forKey: .GitHubAccessToken)
        }
    }
    @Published var requestError: RequestError? = nil

    var githubAccessTokenBinder: Binding<String?> {
        Binding(get: {
            self.githubAccessToken
        }, set: {
            self.githubAccessToken = $0
        })
    }
    var isAuthorized: Bool {
        githubAccessToken != nil
    }
    var hasNotWatching: Bool { watchings.isEmpty }
    var isNotYetLoad: Bool { watchingListFetchStatus == .notYetLoad }

    private var watchingListFetchStatus: WatchingListFetchStatus = .notYetLoad
}

internal extension RootViewModel {
    func fetchIfHasNotWatching() {
        if !hasNotWatching {
            return
        }
        watchingListFetchStatus = .loading
        GitHubAPI
            .request(request: WatchingsRequest())
            .map ({ watchings in
                // TODO: fetch isReceiveNotification
                return watchings
                    .map { WatchingModel.create(entity: $0, isReceiveNotification: false) }
                    .distinct()
            })
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.watchingListFetchStatus = .loaded
                    
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.requestError = error
                    }
                },
                receiveValue: { [weak self] watchings in
                    self?.watchings = watchings
                }
                
        ).store(in: &canceller)
    }
}

extension RootViewModel {
    enum WatchingListFetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
}
