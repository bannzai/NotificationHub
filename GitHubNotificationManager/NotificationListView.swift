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
    @State private var viewModel = NotificationListViewModel()
    @EnvironmentObject var hud: HUDViewModel
    @State var text: String = ""
    
    var body: some View {
        List {
            SearchBar(text: $text)
            ForEach(viewModel.notifications) { notification in
                NavigationButton(destination: SafariView(url: notification.subject.destinationURL)) {
                    Cell(notification: notification)
                }
            }
            }
            .onReceive(viewModel.didChange, perform: {
                self.hud.hide()
            })
            .onAppear {
                self.hud.show()
                self.viewModel.fetch()
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
