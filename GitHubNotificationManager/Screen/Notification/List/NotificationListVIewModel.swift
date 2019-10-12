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
    
    private var isAlreadyReadLatestContent: Bool {
        allNotifications.count < NotificationsRequest.elementPerPage
    }
    
    private var nextPage: Int? {
        if allNotifications.isEmpty {
            return 0
        }
        if isAlreadyReadLatestContent {
            return nil
        }
        
        return (allNotifications.count + NotificationsRequest.elementPerPage) / NotificationsRequest.elementPerPage - 1
    }
}


func address(_ o: NotificationListViewModel) -> Int {
    unsafeBitCast(o, to: Int.self)
}

internal extension NotificationListViewModel {
    func fetchNext() {
        fetch()
    }
    
    private func fetch() {
        if case .loading = notificationListFetchStatus {
            return
        }
        guard let page = nextPage else {
            return
        }
        
        notificationListFetchStatus = .loading
        print("before :\(address(self))")
        GitHubAPI
            .request(request: NotificationsRequest(page: page, notificationsUrl: listType))
            .handleEvents(receiveCompletion: { [weak self] (_) in
                // FIXME: This parameter should be change after notify changing to View via @Published
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.map {
                        print("handle completion address :\(address($0))")
                    }
                    self?.notificationListFetchStatus = .loaded
                }
            })
            .map ({ notifications in
                notifications.map(NotificationModel.create(entity:))
            })
            .sink(
                receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.requestError = error
                    }
                },
                receiveValue: { [weak self] (notifications) in
                    self.map {
                        print("receive value :\(address($0))")
                    }
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
