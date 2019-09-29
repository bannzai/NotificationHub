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
        let notification: Notification
        private var repository: Notification.Repository { notification.repository }
        private var subject: Notification.Subject { notification.subject }
        var body: some View {
            HStack {
                ThumbnailImageView(url: repository.avatarURL)
                VStack(alignment: .leading) {
                    Text(repository.fullName).font(.headline).lineLimit(1)
                    Text(subject.title).font(.subheadline).lineLimit(1)
                }
            }
        }
    }
}

#if DEBUG
struct NotificationListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView.Cell(
            notification: notification
        )
    }
}
#endif
