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
    @State private var watchings: [WatchingModel] = []
    @State private var currentPage: Int = 0

    @ObservedObject private var viewModel = RootViewModel()

    var body: some View {
        Group {
            if viewModel.isAuthorized {
                NavigationView {
                    PageView(views: pages, page: $currentPage)
                        .navigationBarTitle(Text(navigationTitle), displayMode: .inline)
                        .navigationBarItems(
                            trailing: Button(
                                action: {
                                    self.selectedAddNotificationList = true
                            }, label: {
                                Image(systemName: "text.badge.plus")
                                    .barButtonItems()
                            })
                    ).sheet(isPresented: $selectedAddNotificationList) { () in
                        WatchingListView(watchings: self.$watchings)
                    }.onReceive(viewModel.$watchings, perform: { (watchings) in
                        self.watchings = watchings
                    }).onAppear(perform: {
                        self.viewModel.fetch()
                    })
                }
            } else {
                OAuthView(githubAccessToken: viewModel.githubAccessTokenBinder)
                    .onReceive(viewModel.$githubAccessToken) { (token) in
                        NetworkConfig.Github.accessToken = token
                }}
        }
        
    }
    
    private var pages: [NotificationListView] {
        let main = NotificationListView(listType: .all)
        let sub = watchings
            .filter { $0.isReceiveNotification }
            .map { NotificationListView(listType: .specify(notificationsUrl: $0.notificationsURL)) }
        return [main] + sub
    }
    
    private var navigationTitle: String {
        switch currentPage {
        case 0:
            return "Notifications"
        case _:
            return watchings
                .filter { $0.isReceiveNotification }[currentPage - 1].owner.name
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        ForEach(DeviceType.previewDevices, id: \.self) { device in
            RootView()
                .previewDevice(device.preview)
                .previewDisplayName(device.name)
        }
    }
}
#endif
