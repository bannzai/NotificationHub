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
                    ).onAppear(perform: {
                        self.viewModel.fetchIfHasNotWatching()
                    }).alert(item: $viewModel.requestError) { (error) in
                        Alert(
                            title: Text("Fetched Error"),
                            message: Text(error.localizedDescription),
                            dismissButton: .default(Text("OK"))
                        )
                    }.sheet(isPresented: $selectedAddNotificationList) { () in
                        WatchingListView(watchings: self.$viewModel.watchings)
                    }
                }
            } else {
                OAuthView(githubAccessToken: viewModel.githubAccessTokenBinder)
            }
        }
        
    }
    
    private var pages: [PageViewDataContainer<NotificationListView, WatchingModel>] {
        if viewModel.isNotYetLoad {
            return []
        }
//        let main: PageViewDataContainer = PageViewDataContainer(object: 0, view: NotificationListView(listType: .all))
        let sub: [PageViewDataContainer] = viewModel.watchings
            .filter { $0.isReceiveNotification }
            .map { PageViewDataContainer(object: $0, view: NotificationListView(listType: .specify(notificationsUrl: $0.notificationsURL))) }
        return sub
    }
    
    private var navigationTitle: String {
        switch currentPage {
        case 0:
            return "Notifications"
        case _:
            return viewModel.watchings
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
