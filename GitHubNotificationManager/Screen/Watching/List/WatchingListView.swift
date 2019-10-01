//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    // FIXME: Keep data when presented this view
    @Binding var watchings: [WatchingModel]

    func watching(of index: Int) -> Binding<WatchingModel> {
        Binding(get: {
            self.watchings[index]
        }) { (watching) in
            self.watchings[index] = watching
        }
    }
    
    var body: some View {
        List(watchings.indices, id: \.self) { (index) in
            Cell(watching: self.watching(of: index))
        }
    }
}

#if DEBUG
//struct WatchingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchingListView(watchings: [], fetched: { _ in })
//    }
//}
#endif
