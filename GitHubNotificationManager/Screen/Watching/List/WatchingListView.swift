//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    private var viewModel = WatchingListViewModel()
    @State var watchings: [WatchingModel] = []
    @EnvironmentObject var hud: HUDViewModel
    
    var body: some View {
        List{
            ForEach(watchings.enumerated().map { $0.offset }, id: \.self) { (index) in
                Cell(watching: self.$watchings[index])
            }
        }.onReceive(viewModel.$watchings, perform: { (watchings) in
            self.watchings = watchings
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
