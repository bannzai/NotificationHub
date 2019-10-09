//
//  PageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI

final class PageViewModel {
    // Dummy state
    private var _currentPage: Int = 0 {
        didSet {
            didChangeCurrentPage(_currentPage)
        }
    }
    var didChangeCurrentPage: ((Int) -> Void)!
    func currentPage() -> Binding<Int> {
        Binding<Int>(get: { self._currentPage },
                     set: { self._currentPage = $0 })
    }
}

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var viewModel: PageViewModel = PageViewModel()

    init(views: [Page], didChangeCurrentPage: @escaping (Int) -> Void) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        viewModel.didChangeCurrentPage = didChangeCurrentPage
    }

    var body: some View {
        PageViewController(
            viewControllers: viewControllers,
            currentPage: viewModel.currentPage()
        )
    }
}

#if DEBUG
struct PageView_Preview: PreviewProvider {
    @State static var currentPage: Int = 0
    static var previews: some View {
        PageView(views: [EmptyView()]) {
            print($0)
        }
    }
}
#endif
