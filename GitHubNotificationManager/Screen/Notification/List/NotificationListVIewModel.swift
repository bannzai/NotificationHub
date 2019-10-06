//
//  NotificationVIewModel.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GitHubNotificationManagerNetwork

final public class NotificationListViewModel: ObservableObject {
    private var canceller: Set<AnyCancellable> = []
    
    @Published private var allNotifications: [NotificationModel] = []
    @Published internal var searchWord: String = ""

    private var notificationListFetchStatus: NotificationListFetchStatus = .notYetLoad

    let repository: NotificationsRepository
    init(repository: NotificationsRepository) {
        self.repository = repository
    }
    
    private var filteredNotifications: [NotificationModel] {
        allNotifications.filter { $0.match(for: searchWord) }
    }
    internal var notifications: [NotificationModel] {
        searchWord.isEmpty ? allNotifications : filteredNotifications
    }
    internal var isNoData: Bool {
        allNotifications.isEmpty && notificationListFetchStatus == .loaded
    }

}

internal extension NotificationListViewModel {
    func fetchNext() {
        if case .notYetLoad = notificationListFetchStatus {
            return
        }
        fetch()
    }
    
    func fetchFirst() {
        guard case .notYetLoad = notificationListFetchStatus else {
            return
        }
        fetch()
    }
    
    private func fetch() {
        if case .loading = notificationListFetchStatus {
            return
        }

        notificationListFetchStatus = .loading
        repository
            .fetch(page: allNotifications.count / NotificationsRequest.perPage)
            .catch { (_) in
                Just([NotificationElement]())
        }
        .handleEvents(receiveOutput: { [weak self] (elements) in
            self?.notificationListFetchStatus = .loaded
        })
        .map { notifications in
            return notifications
                .filter { !$0.repository.repositoryPrivate }
                .map(NotificationModel.create(entity:))
        }
        .sink(receiveValue: { [weak self] (notifications) in
            self?.allNotifications += notifications
        })
        .store(in: &canceller)
    }
}

extension NotificationListViewModel {
    enum NotificationListFetchStatus {
        case notYetLoad
        case loaded
        case loading
    }
}
