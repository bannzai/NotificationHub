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
    var didChangePage: (Int) -> Void

    var body: some View {
        PageView(views: pages, didChangePage: didChangePage)
    }
    
    private var pages: [NotificationListView] {
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
    var viewModel: PageViewModel

    init(views: [Page], didChangePage: @escaping (Int) -> Void) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        let viewModel = PageViewModel(didChangePage: didChangePage)
        currentPage = Binding<Int>(
            get: { [weak viewModel] in viewModel?.currentPage ?? 0 },
            set: { [weak viewModel] in viewModel?.currentPage = $0 }
        )
        self.viewModel = viewModel
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
        PageView(views: [EmptyView()], didChangePage: { _ in
            
        })
    }
}
#endif
