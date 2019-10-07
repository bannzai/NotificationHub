//
//  NotificationListView.Cell.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine

struct CheckMarkButton: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) { () in
            if isChecked {
                Image(systemName: "eye")
            } else {
                Image(systemName: "eye.fill")
            }
        }
    }
}

extension NotificationListView {
    struct Cell: View {
        let notification: NotificationModel
        var body: some View {
            HStack {
                ImageLoaderView(url: notification.repository.avatarURL)
                    .modifier(ThumbnailImageViewModifier())
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
