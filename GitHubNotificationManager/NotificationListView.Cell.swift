//
//  NotificationListView.Cell.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine

extension NotificationListView {
    struct Cell: View {
        let notification: NotificationListViewModel.Notification
        var body: some View {
            HStack {
                Image(systemName: "envelope.badge")
                Text(Optional(notification.repository).map { $0.ownerName + "/" + $0.name }!).bold()
            }
            
        }
    }
}

#if DEBUG
struct NotificationListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView.Cell(notification: NotificationListViewModel.Notification(id: "", reason: "reason", repository: NotificationListViewModel.Notification.Repository(id: 1, name: "name", ownerName: "owner name"), url: "https://github.com"))
    }
}
#endif
