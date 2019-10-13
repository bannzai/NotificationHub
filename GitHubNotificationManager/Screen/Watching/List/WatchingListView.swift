//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct WatchingListView: View {
    @EnvironmentObject var store: Store<AppState>
    
    var body: some View {
        List(store.state.watchingListState.watchings) { (watching) in
            StoreProvider(store: self.store) {
                Cell(watching: watching)
            }
        }
        .onAppear {
            self.store.dispatch(action: WatchingsFetchAction(canceller: sharedStore))
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
