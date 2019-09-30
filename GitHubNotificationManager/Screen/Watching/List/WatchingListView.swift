//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    @ObservedObject var viewModel = WatchingListViewModel()
    @EnvironmentObject var hud: HUDViewModel

    var body: some View {
        ForEach(viewModel.watchings) { watching in
            Cell(watching: watching)
        }
        .onReceive(viewModel.objectWillChange, perform: { (_) in
            self.hud.hide()
        })
            .onAppear {
                self.hud.show()
                self.viewModel.fetch()
        }
    }
}

#if DEBUG
struct WatchingListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchingListView()
    }
}
#endif
