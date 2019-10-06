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
    @Published var requestError: RequestError? = nil

    private var notificationListFetchStatus: NotificationListFetchStatus = .notYetLoad

    let listType: NotificationListView.ListType
    init(listType: NotificationListView.ListType) {
        self.listType = listType
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
        GitHubAPI
            .request(request: NotificationsRequest(page: allNotifications.count / NotificationsRequest.perPage, notificationsUrl: listType))
            .handleEvents(receiveCompletion: { [weak self] completion in
                self?.notificationListFetchStatus = .loaded
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.requestError = error
                }
            })
            .catch { (_) in
                Just([NotificationElement]())
        }
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
