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
    @State private var selectedAddNotificationList: Bool = false
    
    // FIXME: Keep data when presented this view
    @State var watchings: [WatchingModel] = []
    
    var pages: [NotificationListView] {
        let main = NotificationListView()
        let sub = watchings
            .filter { $0.isReceiveNotification }
            .map { _ in NotificationListView() }
        return [main] + sub
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                PageView(views: pages).navigationBarTitle(Text("Notifications"))
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
                })
            }
            .onAppear {
                print("RootView Appear")
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
