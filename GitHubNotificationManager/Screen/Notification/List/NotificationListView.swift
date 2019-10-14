//
//  NotificationListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct NotificationListView : RenderableView {
    @EnvironmentObject var store: Store<AppState>
    @State private var selectedNotification: NotificationElement? = nil
    let state: NotificationsState

    struct Props {
        let searchWord: Binding<String>
        let notifications: [NotificationElement]
        let isNoData: Bool
        let watchingOwnerName: String?
    }
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(
            searchWord: Binding<String>(
                get: { state.notificationPageState.currentState.searchWord },
                set: { dispatch(SearchRequestAction(text: $0)) }
            ),
            notifications: self.state.visiblyNotifications,
            isNoData: self.state.visiblyNotifications.isEmpty,
            watchingOwnerName: self.state.watching?.owner.login
        )
    }
    
    func body(props: Props) -> some View {
        Group {
            if props.isNoData {
                RetryableNoDataView(message: "No Notifications", action: {
                    self.fetch(props: props)
                })
            } else {
                List {
                    SearchBar(text: props.searchWord)
                    ForEach(props.notifications) { notification in
                        StoreProvider(store: self.store) {
                            Cell(
                                notification: notification,
                                didSelectCell: { self.selectedNotification = $0 }
                            )
                        }
                    }
                    IndicatorView()
                        .frame(maxWidth: .infinity,  idealHeight: 44, alignment: .center)
                        .onAppear {
                            self.fetch(props: props)
                    }
                }
            }
        }
        .sheet(item: $selectedNotification) { (notification) in
            SafariView(url: self.destinationURL(subject: notification.subject))
        }
        .onAppear {
            if props.isNoData {
                self.fetch(props: props)
            }
        }
    }
}

private extension NotificationListView {
    private func fetch(props: Props) {
        store.dispatch(action: NotificationsFetchAction(canceller: sharedStore))
    }
    
    // FIXME: from https://api.github.com/repos/{Owner}/{RepoName}/pulls/{Number}
    private func destinationURL(subject: Subject) -> URL {
        guard let components = URLComponents(string: subject.url) else {
            fatalError("Missing format url from API")
        }
        
        let path = components
            .path
            .components(separatedBy: "/")
            .filter { !$0.isEmpty }
            .enumerated()
            .reduce("/") { (result, elements) in
                let isReposPath = elements.offset == 0
                if isReposPath {
                    return result
                }
                let isPulls = elements.offset == 3
                if isPulls {
                    return result + "/" + "pull"
                }
                return result + "/" + elements.element
        }
        return URL(string: "https://github.com" + path)!
    }
}
