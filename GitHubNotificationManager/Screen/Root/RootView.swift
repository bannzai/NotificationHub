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
    
    @ObservedObject private var viewModel = RootViewModel()
    @State var watchings: [WatchingModel] = []

    var pages: [NotificationListView] {
        let main = NotificationListView(listType: .all)
        let sub = watchings
            .filter { $0.isReceiveNotification }
            .map { NotificationListView(listType: .specify(notificationsUrl: $0.notificationsURL)) }
        return [main] + sub
    }
    
    var body: some View {
        Group {
            if viewModel.isAuthorized.wrappedValue {
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
                        WatchingListView(watchings: self.$watchings)
                    }.onReceive(viewModel.$watchings, perform: { (watchings) in
                        self.watchings = watchings
                    }).onAppear(perform: {
                        self.viewModel.fetchFirst()
                    })
                }
            } else {
                OAuthView(isAuthorized: viewModel.isAuthorized)
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
