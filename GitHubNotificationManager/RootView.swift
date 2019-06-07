//
//  RootView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct RootView: View {
    var body: some View {
        NavigationView {
            ZStack {
                if HUD.counter == 0 {
                    EmptyView()
                } else {
                    HUD.shared
                }
                NotificationListView()
            }
            }
            .onReceive(HUDPublisher.shared, perform: {
                
            })
            .navigationBarTitle(Text("Notifications").color(.gray))
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
