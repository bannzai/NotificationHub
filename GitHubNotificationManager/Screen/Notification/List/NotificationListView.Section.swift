//
//  NotificationListView.Section.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

extension NotificationListView {
    struct SectionView: RenderableView {
        @EnvironmentObject var store: Store<AppState>
        
        let date: String
        let watching: WatchingElement?
        
        struct Props {
            let title: String
            let unreadBinding: Binding<Bool>
        }

        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                title: date,
                unreadBinding: Binding<Bool>(
                    get: { false },
                    set: { _ in dispatch(ReadNotificationAction(watching: self.watching, sectionDate: self.date, canceller: sharedStore)) }
                )
            )
        }
        
        func body(props: Props) -> some View {
            HStack {
                Text(props.title)
                Spacer()
                ReadButton(read: props.unreadBinding)
            }
        }
    }
}

struct NotificationListView_Section_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView.SectionView(date: "abc", watching: nil)
    }
}
