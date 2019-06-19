//
//  NotificationDetailView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NotificationDetailView : View {
    let notification: Notification
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(notification.subject.title).font(.title)
                Text(notification.repository.fullName)
            }
            ImageLoaderView(url: notification.repository.avatarURL)
        }
    }
}

#if DEBUG
struct NotificationDetailView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationDetailView(notification: notification)
    }
}
#endif
