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
            UserDefaults.standard.set(githubAccessToken, forKey: .GitHubAccessToken)
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

    private var watchingListFetchStatus: WatchingListFetchStatus = .notYetLoad
}

internal extension RootViewModel {
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
    
    func fetch() {
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
            self.watchings = self.distinct(watchings: watchings)
        }).store(in: &canceller)
    }
}

extension RootViewModel {
    enum WatchingListFetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
}
