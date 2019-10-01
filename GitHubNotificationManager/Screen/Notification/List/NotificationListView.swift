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
    enum ListType {
        case all
        case specify(notificationsUrl: String)
    }
    @ObservedObject private var viewModel = NotificationListViewModel()
    @State var selectedNotification: NotificationModel? = nil
    
    let listType: ListType
    init(listType: ListType) {
        self.listType = listType
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
