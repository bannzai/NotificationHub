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
    @State var currentPage = 0

    init(views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(viewControllers: viewControllers, currentPage: $currentPage)
    }
}

#if DEBUG
//struct PageView_Preview: PreviewProvider {
//    static var previews: some View {
////        PageView()
//    }
//}
#endif
