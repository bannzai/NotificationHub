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
    
    private var loading: Bool { hud.counter > 0 }
    @State private var selectedAddNotificationList: Bool = false
    
    // FIXME: Keep data when presented this view
    @State var watchings: [WatchingModel] = []
    
    var notificationListViews: [NotificationListView] {
        let all = NotificationListView()
        let filtered = watchings
            .filter { $0.isReceiveNotification }
            .map { _ in NotificationListView() }
        return [all] + filtered
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                PageView(
                    pages: notificationListViews
                ).navigationBarTitle(Text("Notifications"))
                
                if self.loading {
                    HUD()
                } else {
                    EmptyView()
                }
            }.navigationBarItems(
                trailing: Button(action: {
                    self.selectedAddNotificationList = true
                }, label: {
                    Image(systemName: "text.badge.plus")
                        .renderingMode(.template)
                        .background(Color.primary)
                })
            ).sheet(isPresented: $selectedAddNotificationList) { () in
                // FIXME: Keep data when presented this view
                WatchingListView(
                    watchings: self.watchings,
                    fetched: { (watchings) in
                        self.watchings = watchings
                }).environmentObject(self.hud)
            }
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
