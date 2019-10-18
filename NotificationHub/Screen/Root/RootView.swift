//
//  RootView.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import NotificationHubCore
import NotificationHubRedux

final class RootViewStore: ObservableObject {
    let subject = CurrentValueSubject<String?, Never>(nil)
    var canceller: Set<AnyCancellable> = []
    @Published var token: String? = nil
    
    init() {
        sharedStore
            .objectDidChange
            .map { sharedStore.state.authentificationState.githubAccessToken }
            .sink { [weak self] (state) in self?.subject.value = state }
            .store(in: &canceller)
        
        subject
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in self?.token = $0 })
            .store(in: &canceller)
    }
}

struct RootView: View {
    @State private var selectedAddNotificationList: Bool = false
    @State var currentPage: Int = 0
    @ObservedObject var store: RootViewStore = RootViewStore()

    var body: some View {
        Group {
            if sharedStore.state.authentificationState.isAuthorized {
                ZStack {
                    NavigationView {
                        NotificationListPageView()
                            .modifier(NavigationBarTitleModifier())
                            .navigationBarItems(
                                trailing: Button(
                                    action: {
                                        self.selectedAddNotificationList = true
                                }, label: {
                                    Image(systemName: "text.badge.plus")
                                        .barButtonItems()
                                })
                        )
                    }
                    HUD()
                }
                .sheet(isPresented: $selectedAddNotificationList) { () in
                    StoreProvider(store: sharedStore) { WatchingListView() }
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
