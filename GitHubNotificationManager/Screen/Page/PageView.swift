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
    var views: [NotificationListView]

    init(views: [NotificationListView]) {
        self.views = views
    }
    
    var body: some View {
        PageView(views: views)
    }
}

var _currentPage: Int = 0
struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var currentPage: Binding<Int> = Binding<Int>(get: { _currentPage }, set: { _currentPage = $0 })

    init(views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
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
        PageView(views: [EmptyView()])
    }
}
#endif
