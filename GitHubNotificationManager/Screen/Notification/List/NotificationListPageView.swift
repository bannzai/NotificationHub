//
//  NotificationListPageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/01.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NotificationListPageView: View {
    @Binding var watchings: [WatchingModel]
    var pages: [NotificationListView] {
        let main = NotificationListView()
        let sub = watchings
            .filter { $0.isReceiveNotification }
            .map { _ in NotificationListView() }
        return [main] + sub
    }
    
    var body: some View {
        PageView(views: pages)
    }
}

#if DEBUG
struct NotificationListPageView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListPageView(watchings: State(initialValue: [WatchingModel]()).projectedValue)
    }
}
#endif
