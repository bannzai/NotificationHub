//
//  NavigationBarTitleModifier.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/12.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NavigationBarTitleModifier: ViewModifier {
    @EnvironmentObject var store: Store<AppState>
    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text(store.state.title), displayMode: .inline)
    }
}
