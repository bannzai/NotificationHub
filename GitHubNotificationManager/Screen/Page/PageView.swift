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
    var watchings: [WatchingModel]
    @State var currentPage: Int = 0

    var body: some View {
        PageView(views: pages, currentPage: $currentPage)
            .navigationBarTitle(Text(title), displayMode: .inline)
    }

    private var title: String {
        switch currentPage == 0 {
        case true:
            return "Notifications"
        case false:
            return watchings[currentPage].owner.name
        }
    }
    
    private var pages: [NotificationListView] {
        if watchings.isEmpty {
            return []
        }
        let main = NotificationListView(listType: .all)
        let sub = watchings
            .filter { $0.isReceiveNotification }
            .map { NotificationListView(listType: .specify(watching: $0)) }
        return [main] + sub
    }
}

final class PageViewModel: ObservableObject {
    var currentPage: Int = 0 {
        didSet {
            didChangePage(currentPage)
        }
    }
    var didChangePage: (Int) -> Void
    
    init(didChangePage: @escaping (Int) -> Void) {
        self.didChangePage = didChangePage
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
