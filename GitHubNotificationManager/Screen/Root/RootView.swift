//
//  RootView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct RootView: RenderableView {
    @EnvironmentObject var store: Store
    @State private var selectedAddNotificationList: Bool = false
    
    struct Props {
        let isAuthorized: Bool
        let title: String
        let currentPage: Binding<Int>
    }
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(
            isAuthorized: state.authentificationState.isAuthorized,
            title: state.title,
            currentPage:Binding<Int>(
                get: { state.notificationPageState.currentNotificationPage },
                set: { dispatch(ChangeNotificationPageAction(page: $0)) }
            )
        )
    }

    func body(props: Props) -> some View {
        Group {
            if props.isAuthorized {
                NavigationView {
                    NotificationListPageView(currentPage: props.currentPage)
                        .navigationBarTitle(Text(props.title), displayMode: .inline)
                        .navigationBarItems(
                            trailing: Button(
                                action: {
                                    self.selectedAddNotificationList = true
                            }, label: {
                                Image(systemName: "text.badge.plus")
                                    .barButtonItems()
                            })
                    ).alert(item: $store.state.requestError) { (error) in
                        Alert(
                            title: Text("Fetched Error"),
                            message: Text(error.localizedDescription),
                            dismissButton: .default(Text("OK"))
                        )
                    }.sheet(isPresented: $selectedAddNotificationList) { () in
                        StoreProvider(store: self.store) { WatchingListView() }
                    }
                }
                .onAppear {
                    self.store.dispatch(action: WatchingsFetchAction(canceller: sharedStore))
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
