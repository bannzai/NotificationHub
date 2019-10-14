//
//  NotificationListView.Section.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

extension NotificationListView {
    struct SectionView: RenderableView {
        @EnvironmentObject var store: Store<AppState>
        
        let title: String
        struct Props {
            let title: String
            let unreadBinding: Binding<Bool>
        }

        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                title: title,
                unreadBinding: Binding<Bool>(
                    get: { false },
//                    set: { $0 ? dispatch(UnReadNotificationAction(notificationId: self.notification.id)) : dispatch(ReadNotificationAction(notificationId: self.notification.id)) }
                    set: { fatalError("\($0)") }
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
        NotificationListView.SectionView(title: "abc")
    }
}
