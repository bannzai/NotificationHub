//
//  PageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI

struct NotificationListPageView: View {
    @Binding var currentPage: Int

    var pages: [NotificationListView] {
        sharedStore
            .state
            .notificationPageState
            .notificationsStatuses
            .filter { $0.isVisible }
            .map { _ in
                NotificationListView()
        }
    }
    
    var body: some View {
        PageView(views: pages, currentPage: $currentPage)
    }
}

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var currentPage: Binding<Int>

    init(views: [Page], currentPage: Binding<Int>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self.currentPage = currentPage
    }

    var body: some View {
        PageViewController(
            viewControllers: viewControllers,
            currentPage: currentPage
        )
    }
}

#if DEBUG
struct PageView_Preview: PreviewProvider {
    @State static var currentPage: Int = 0
    static var previews: some View {
        PageView(views: [EmptyView()], currentPage: $currentPage)
    }
}
#endif
