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
//    var viewControllers: [UIHostingController<Page>]
    let pages: [Page]
    @State var currentPage = 0

    init(pages: [Page]) {
        self.pages = pages
    }

    var body: some View {
        PageViewController(pages: pages, currentPage: $currentPage.projectedValue)
    }
}

#if DEBUG
//struct PageView_Preview: PreviewProvider {
//    static var previews: some View {
////        PageView()
//    }
//}
#endif
