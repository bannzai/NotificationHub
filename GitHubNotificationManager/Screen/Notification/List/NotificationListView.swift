//
//  NotificationListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct NotificationListView : View {
    @ObservedObject private var viewModel: NotificationListViewModel
    @State private var selectedNotification: NotificationModel? = nil

    init(listType: ListType) {
        viewModel = NotificationListViewModel(listType: listType)
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
                    ForEach(viewModel.notifications) { notification in
                        Cell(binding: self.viewModel.binding(notification: notification)) {
                            self.selectedNotification = $0
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
        .sheet(item: $selectedNotification) { (notification) in
            SafariView(url: notification.subject.destinationURL)
        }
        .alert(item: $viewModel.requestError) { (error) in
            Alert(
                title: Text("Fetched Error"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }}
}

extension NotificationListView {
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
}


#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView(listType: .all)
    }
}
#endif
