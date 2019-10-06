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
    var views: [Page]
    var currentPage: Binding<Int>

    init(views: [Page], page: Binding<Int>) {
        self.views = views
        self.currentPage = page
    }

    var body: some View {
        PageViewController(
            views: views,
            currentPage: currentPage
        )
    }
}

#if DEBUG
struct PageView_Preview: PreviewProvider {
    @State static var currentPage: Int = 0
    static var previews: some View {
        PageView(views: [EmptyView()], page: $currentPage)
    }
}
#endif
