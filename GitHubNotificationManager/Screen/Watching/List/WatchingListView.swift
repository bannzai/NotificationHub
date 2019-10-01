//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    @ObservedObject private var viewModel: WatchingListViewModel

    // FIXME: Keep data when presented this view
    var fetched: ([WatchingModel]) -> ()

    init(
        watchings defaultWatchings: [WatchingModel],
        fetched: @escaping ([WatchingModel]) -> ()
    ) {
        self.fetched = fetched
        self.viewModel = WatchingListViewModel(watchings: defaultWatchings)
    }

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
        }.onReceive(viewModel.$watchings, perform: { (watchings) in
            self.fetched(watchings)
        }).onAppear {
            self.viewModel.fetch()
        }
    }
}

#if DEBUG
struct WatchingListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchingListView(watchings: [], fetched: { _ in })
    }
}
#endif