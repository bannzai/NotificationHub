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

    @Published var watchings: [WatchingEntity] = []
    let allNotificationViewModel = NotificationListViewModel(listType: .all)
    @Published var notificationViewModelForWatching: [WatchingEntity: NotificationListViewModel] = [:]
    var activateNotificationViewModels: [NotificationListViewModel] {
        notificationViewModelForWatching
            .map { (key: $0.key, value: $0.value)}
            .sorted { $0.key < $1.key }
            .filter { $0.key.isReceiveNotification }
            .map { $0.value }
    }
    @Published var githubAccessToken: String? = UserDefaults.standard.string(forKey: .GitHubAccessToken) {
        didSet {
            NetworkConfig.Github.accessToken = githubAccessToken
            UserDefaults.standard.set(githubAccessToken, forKey: .GitHubAccessToken)
        }
    }
    @Published var requestError: RequestError? = nil
    @Published var currentPage: Int = 0
    
    var title: String {
        switch currentPage == 0 {
        case true:
            return "Notifications"
        case false:
            return watchings.filter { $0.isReceiveNotification }[currentPage - 1].owner.name
        }
    }
    
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
        let mappedRequest = GitHubAPI
            .request(request: WatchingsRequest())
            .map ({ watchings in
                // TODO: fetch isReceiveNotification
                return watchings
                    .map { WatchingEntity.create(element: $0, isReceiveNotification: false) }
                    .distinct()
            })
        
        mappedRequest
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
        
        mappedRequest
            .catch { _ in Just([WatchingEntity]()) }
            .sink(
                receiveValue: { [weak self] watchings in
                    watchings.forEach {
                        self?.notificationViewModelForWatching[$0] = NotificationListViewModel(listType: .specify(watching: $0))
                    }
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
