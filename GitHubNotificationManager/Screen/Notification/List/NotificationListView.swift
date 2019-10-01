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
    
    init(listType: ListType) {
        viewModel = NotificationListViewModel(listType: listType)
    }

    var body: some View {
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
        .onAppear {
            self.viewModel.fetchFirst()
        }
        .sheet(item: $selectedNotification) { (notification) in
            SafariView(url: notification.subject.destinationURL)
        }
    }
}


#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView(listType: .all).environmentObject(HUDViewModel())
    }
}
#endif
