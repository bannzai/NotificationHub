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
    
    @Published private var allNotifications: [Notification] = []
    @Published internal var searchWord: String = ""

    private var filteredNotifications: [Notification] {
        allNotifications.filter { $0.match(for: searchWord) }
    }
    
    internal var notifications: [Notification] {
        searchWord.isEmpty ? allNotifications : filteredNotifications
    }
}

internal extension NotificationListViewModel {
    private func mapToNotificationModel(entity: NotificationElement) -> Notification {
        Notification(
            id: entity.id,
            reason: entity.reason,
            repository: Notification.Repository(
                id: entity.repository.id,
                name: entity.repository.name,
                ownerName: entity.repository.owner.login,
                avatarURL: entity.repository.owner.avatarURL,
                fullName: entity.repository.fullName
            ),
            subject: Notification.Subject(
                title: entity.subject.title,
                url: entity.subject.url
            ),
            url: entity.url
        )
    }
    func fetch() {
        GitHubAPI
            .request(request: NotificationsRequest())
            .catch { (_) in
                Just([NotificationElement]())
        }
        .map { [weak self] notifications in
            guard let self = self else {
                return []
            }
            return notifications
                .filter { !$0.repository.repositoryPrivate }
                .map(self.mapToNotificationModel(entity:))
        }
        .sink(receiveValue: { [weak self] (notifications) in
            self?.allNotifications += notifications
            }
        )
        .store(in: &canceller)
    }
}
