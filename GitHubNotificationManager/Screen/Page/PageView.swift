//
//  PageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var currentPage: Binding<Int>

    init(views: [Page], page: Binding<Int>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self.currentPage = page
    }

    var body: some View {
        PageViewController(
            viewControllers: viewControllers,
            currentPage: currentPage
        )
    }
}

#if DEBUG
//struct PageView_Preview: PreviewProvider {
//    static var previews: some View {
////        PageView()
//    }
//}
#endif
