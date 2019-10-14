//
//  NotificationListView.Cell.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import GitHubNotificationManagerNetwork

extension NotificationListView {
    struct Cell: View {
        let notification: NotificationElement
        let didSelectCell: (NotificationElement) -> Void
        
        struct Props {
            let notification: NotificationElement
        }
        
        var cellGestuer: some Gesture {
            TapGesture().onEnded {
                self.didSelectCell(self.notification)
            }
        }
        
        var body: some View {
            HStack {
                Group {
                    ImageLoaderView(url: notification.repository.owner.avatarURL, defaultImage: UIImage(systemName: "person")!)
                        .modifier(ThumbnailImageViewModifier())
                    VStack(alignment: .leading) {
                        Text(notification.repository.fullName).font(.headline).lineLimit(1)
                        Text(notification.subject.title).font(.subheadline).lineLimit(1)
                    }
                }
                .layoutPriority(DefaultLayoutPriority + 1)
                .gesture(cellGestuer)
            }
        }
    }
}

// TODO:
//#if DEBUG
//struct NotificationListView_Cell_Previews : PreviewProvider {
//    static var previews: some View {
//        fatalError("TODO:")
//    }
//}
//#endif
