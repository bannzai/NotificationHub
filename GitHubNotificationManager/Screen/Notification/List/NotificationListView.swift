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
    @ObservedObject private var viewModel = NotificationListViewModel()
    @EnvironmentObject var hud: HUDViewModel
    @State var selectedNotification: NotificationModel? = nil

    var body: some View {
        List {
            SearchBar(text: $viewModel.searchWord)
            ForEach(viewModel.notifications) { notification in
                Button(action: {
                    self.selectedNotification = notification
                }) {
                    Cell(notification: notification)
                }
            }
        }
        .onReceive(viewModel.objectWillChange, perform: { (_) in
            self.hud.hide()
        })
        .onAppear {
            self.hud.show()
            self.viewModel.fetch()
        }
        .sheet(item: self.$selectedNotification) { (notification) in
            SafariView(url: notification.subject.destinationURL)
        }
    }
}


#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView().environmentObject(HUDViewModel())
    }
}
#endif
