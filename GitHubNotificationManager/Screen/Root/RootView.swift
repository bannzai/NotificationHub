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
    @State var currentPage: Int = 0

    var body: some View {
        Group {
            if sharedStore.state.authentificationState.isAuthorized {
                NavigationView {
                    NotificationListPageView()
                        .navigationBarTitle(Text(sharedStore.state.title), displayMode: .inline)
                        .navigationBarItems(
                            trailing: Button(
                                action: {
                                    self.selectedAddNotificationList = true
                            }, label: {
                                Image(systemName: "text.badge.plus")
                                    .barButtonItems()
                            })
                    ).sheet(isPresented: $selectedAddNotificationList) { () in
                        StoreProvider(store: sharedStore) { WatchingListView() }
                    }
                }
                .onAppear {
                    sharedStore.dispatch(action: WatchingsFetchAction(canceller: sharedStore))
                }
            } else {
                OAuthView()
            }
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
