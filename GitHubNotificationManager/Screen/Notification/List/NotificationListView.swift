//
//  NotificationListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork
import Combine

struct NotificationListView : View {
    enum ListType: NotificationPath {
        case all
        case specify(notificationsUrl: String)
        
        var notificationPath: URLPathConvertible {
            switch self {
            case .all:
                return "notifications"
            case .specify(notificationsUrl: let url):
                // e.g) https://api.github.com/repos/bannzai/vimrc/notifications{?since,all,participating}
                // Drop {?since, all, participating}
                return url
                    .split(separator: "/")
                    .reduce(into: "") { (result, element) in
                        switch element {
                        case "/":
                            return
                        case "https:", "api.github.com":
                            return
                        case _:
                            break
                        }
                        
                        switch element.contains("{") {
                        case false:
                            // repos bannzai vimrc
                            result += element + "/"
                        case true:
                            result += element.split(separator: "{").dropLast().joined()
                        }
                }
            }
        }
    }
    @ObservedObject private var viewModel: NotificationListViewModel
    @State var selectedNotification: NotificationModel? = nil
    
    init(viewModel: NotificationListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if viewModel.isNoData {
                RetryableNoDataView(message: "No Notifications", action: {
                    self.viewModel.fetchNext()
                })
            } else {
                List {
                    SearchBar(text: $viewModel.searchWord)
                    ForEach(viewModel.notifications, id: \.id) { notification in
                        Button(action: {
                            self.selectedNotification = notification
                        }) {
                            Cell(notification: notification)
                        }
                    }
                    IndicatorView()
                        .frame(maxWidth: .infinity,  idealHeight: 44, alignment: .center)
                        .onAppear {
                            self.viewModel.fetchNext()
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.fetchFirst()
        }
        .sheet(item: $selectedNotification) { (notification) in
            SafariView(url: notification.subject.destinationURL)
        }
    }
}


#if DEBUG
struct ErrorRepository: NotificationsRepository {
    init() { }
    func fetch(page: Int) -> AnyPublisher<NotificationsRequest.Response, RequestError> {
        Fail(error: RequestError(error: NSError(domain: "com.preview.bannzai.notificationhub", code: 999, userInfo: nil))).eraseToAnyPublisher()
    }
}
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView(viewModel: NotificationListViewModel(repository: NotificationsRepositoryImpl(pathType: NotificationListView.ListType.all)))
    }
}
#endif
