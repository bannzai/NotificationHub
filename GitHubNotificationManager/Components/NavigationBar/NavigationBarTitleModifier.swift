//
//  NavigationBarTitleModifier.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/12.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NavigationBarTitleModifier: ViewModifier {
    let title: String
    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text(title), displayMode: .inline)
    }
}
