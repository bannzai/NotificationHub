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

final public class NotificationViewModel: BindableObject {
    public let didChange = PassthroughSubject<[GitHubNotificationManagerNetwork.Notification], Never>()
    
    func fetch() {
        _ = GitHubAPI.request(request: NotificationsRequest())
            .replaceError(with: [])// FIXKE: How to convert for Failure type to Never
            .subscribe(didChange)
        }
}
