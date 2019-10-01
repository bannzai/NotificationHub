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
    
    private var filteredNotifications: [NotificationModel] {
        allNotifications.filter { $0.match(for: searchWord) }
    }
    
    internal var notifications: [NotificationModel] {
        searchWord.isEmpty ? allNotifications : filteredNotifications
    }
    
    private var notificationListFetchStatus: NotificationListFetchStatus = .notYetLoad
}

internal extension NotificationListViewModel {
    func fetchNext() {
        if case .notYetLoad = notificationListFetchStatus {
            return
        }
        if allNotifications.isEmpty {
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
        GitHubAPI
            .request(request: NotificationsRequest(page: allNotifications.count / NotificationsRequest.perPage))
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
