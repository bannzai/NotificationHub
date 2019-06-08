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
    @EnvironmentObject var hud: HUDPublisher
    
    var body: some View {
        List {
            ForEach(viewModel.notifications) { n in Cell(notification: n) }
            }
            .onReceive(hud.didChange, perform: {
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
        NotificationListView().environmentObject(HUDPublisher())
    }
}
#endif
