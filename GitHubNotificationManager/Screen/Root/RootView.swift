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
    @State var selectedAddNotificationList: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                PageView(views: [
                    NotificationListView(),
                    NotificationListView()
                    ]
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
                WatchingListView().environmentObject(self.hud)
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
