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
        let notification: NotificationModel
        var body: some View {
            HStack {
                ThumbnailImageView(url: notification.repository.avatarURL)
                VStack(alignment: .leading) {
                    Text(notification.repository.fullName).font(.headline).lineLimit(1)
                    Text(notification.subject.title).font(.subheadline).lineLimit(1)
                }
            }
        }
    }
}

#if DEBUG
struct NotificationListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView.Cell(
            notification: debugNotification
        )
    }
}
#endif
