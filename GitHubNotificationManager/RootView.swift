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
    @EnvironmentObject var hud: HUDViewModel
    
    var loading: Bool { hud.counter > 0 }
    
    var body: some View {
        NavigationView {
            ZStack {
                NotificationListView()
                if self.loading {
                    HUD()
                } else {
                    EmptyView()
                }
            }
            }
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
