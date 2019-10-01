//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    @ObservedObject private var viewModel = WatchingListViewModel()
    @EnvironmentObject var hud: HUDViewModel
    
    func watching(of index: Int) -> Binding<WatchingModel> {
        Binding(get: {
            self.viewModel.watchings[index]
        }) { (watching) in
            self.viewModel.watchings[index] = watching
        }
    }
    
    var body: some View {
        List(viewModel.watchings.indices, id: \.self) { (index) in
            Cell(watching: self.watching(of: index))
        }.onReceive(viewModel.objectWillChange, perform: { (watchings) in
            self.hud.hide()
        }).onAppear {
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
