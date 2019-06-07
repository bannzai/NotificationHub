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
    
    var body: some View {
        List {
            ForEach(viewModel.notifications) { n in Cell(notification: n) }
            }
            .onReceive(viewModel.didChange, perform: {
                
            })
            .onAppear {
                self.viewModel.fetch()
        }
    }
}


#if DEBUG
struct NotificationListView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
#endif
