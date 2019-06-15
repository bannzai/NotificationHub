//
//  NotificationDetailView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NotificationDetailView : View {
    let notification: NotificationListViewModel.Notification
    
    var body: some View {
        Text(notification.id)
    }
}

#if DEBUG
struct NotificationDetailView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationDetailView(notification: notification)
    }
}
#endif
