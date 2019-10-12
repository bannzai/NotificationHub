//
//  WatchingListView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct WatchingListView: View {
    @Binding var watchings: [WatchingEntity]

    func watching(of index: Int) -> Binding<WatchingEntity> {
        return Binding(get: {
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
struct WatchingListView_Previews: PreviewProvider {
    @State static var watchings: [WatchingEntity] = []
    static var previews: some View {
        WatchingListView(watchings: $watchings)
    }
}
#endif
