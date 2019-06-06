//
//  NotificationListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct NotificationListView : View {
    var body: some View {
        List(NotificationViewModel().notifications) { (n: GitHubNotificationManagerNetwork.Notification) in
            Text("")
        }
    }
}

#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
#endif
