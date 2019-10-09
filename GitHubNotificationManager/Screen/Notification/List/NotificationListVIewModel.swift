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
    func binding(notification: NotificationModel) -> Binding<NotificationModel> {
        Binding(get: {
            notification
        }) { bindingNotification in
            guard let notificationIndex = self.allNotifications
                .firstIndex(where: { $0.id == bindingNotification.id })
                else {
                    return
            }
            self.allNotifications[notificationIndex] = bindingNotification
        }
    }
    
}

internal extension NotificationListViewModel {
    func fetchNext() {
        fetch()
    }
    
    private func fetch() {
        if case .loading = notificationListFetchStatus {
            return
        }

        notificationListFetchStatus = .loading
        let page = (allNotifications.count + NotificationsRequest.elementPerPage) / NotificationsRequest.elementPerPage - 1
        GitHubAPI
            .request(request: NotificationsRequest(page: page, notificationsUrl: listType))
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
            notifications.map(NotificationModel.create(entity:))
        }
        .map { [weak self] notifications in
            let before = self?.allNotifications ?? []
            return before + notifications
        }
        .sink(receiveValue: { [weak self] (notifications) in
            self?.allNotifications = notifications
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
