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
    @State private var selectedNotification: NotificationElement? = nil
    let watching: WatchingElement?
    var state: NotificationsState {
        sharedStore.state.notificationPageState.notificationsStatuses.first(where: { $0.watching?.owner.login == watching?.owner.login })!
    }

    struct Props {
        let notifications: [NotificationElement]
        let canCallFetchWhenOnAppear: Bool
        let canCallFetchWhenReachedBottom: Bool
        let isNoData: Bool
        let watchingOwnerName: String?
    }
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(
            notifications: self.state.notifications,
            canCallFetchWhenOnAppear: self.state.notifications.isEmpty,
            canCallFetchWhenReachedBottom: !self.state.notifications.isEmpty && self.state.nextFetchPage != 0,
            isNoData: self.state.notifications.isEmpty && self.state.fetchStatus != .notYetLoad,
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
                    ForEach(props.notifications) { notification in
                        StoreProvider(store: sharedStore) {
                            Cell(
                                notification: notification,
                                didSelectCell: { self.selectedNotification = $0 }
                            )
                        }
                    }
                    IndicatorView()
                        .frame(maxWidth: .infinity,  idealHeight: 44, alignment: .center)
                        .onAppear {
                            if props.canCallFetchWhenReachedBottom {
                                self.fetch(props: props)
                            }
                    }
                }
            }
        }
        .sheet(item: $selectedNotification) { (notification) in
            SafariView(url: self.destinationURL(subject: notification.subject))
        }
        .onAppear {
            if props.canCallFetchWhenOnAppear {
                self.fetch(props: props)
            }
        }
    }
}

private extension NotificationListView {
    private func fetch(props: Props) {
        sharedStore.dispatch(action: NotificationsFetchAction(watching: watching, canceller: sharedStore))
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
