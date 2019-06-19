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
    
    var body: some View {
        List {
            SearchBar(text: $viewModel.searchWord)
            ForEach(viewModel.notifications) { notification in
                self.navigationButtion()
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
    
    func navigationButtion() -> some View {
        NavigationButton(destination: SafariView(url: notification.subject.destinationURL)) {
            Cell(notification: notification)
            }
            .longPressAction(
                minimumDuration: 1,
                maximumDistance: 1,
                { print("long pressed") }, // action:
                pressing: { (pressing) in print(pressing) }
        )
    }
}


#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView().environmentObject(HUDViewModel())
    }
}
#endif
