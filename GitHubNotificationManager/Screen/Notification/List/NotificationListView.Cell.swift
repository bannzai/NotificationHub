//
//  NotificationListView.Cell.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine

struct CheckMarkButton: View {
    @Binding var isChecked: Bool
    
    let edge: CGFloat = 44
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            if isChecked {
                Image(systemName: "eye")
            } else {
                Image(systemName: "eye.fill")
            }
        }.frame(width: edge, height: edge, alignment: .center)
    }
}

extension NotificationListView {
    struct Cell: View {
        let binding: Binding<NotificationModel>
        let didSelectCell: (NotificationModel) -> Void
        var notification: NotificationModel { binding.wrappedValue }
        
        init(binding: Binding<NotificationModel>, didSelectCell: @escaping (NotificationModel) -> Void) {
            self.binding = binding
            self.didSelectCell = didSelectCell
        }
        
        var cellGestuer: some Gesture {
            TapGesture().onEnded {
                self.didSelectCell(self.notification)
            }
        }
        
        var body: some View {
            return HStack {
                HStack {
                    ImageLoaderView(url: notification.repository.avatarURL)
                        .modifier(ThumbnailImageViewModifier())
                    VStack(alignment: .leading) {
                        Text(notification.repository.fullName).font(.headline).lineLimit(1)
                        Text(notification.subject.title).font(.subheadline).lineLimit(1)
                    }
                    Spacer()
                }
                .gesture(cellGestuer)
                CheckMarkButton(isChecked: binding.unread)
            }
        }
    }
}

#if DEBUG
struct NotificationListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        NotificationListView.Cell(
            binding: State(initialValue: debugNotification).projectedValue,
            didSelectCell: { _ in }
        )
    }
}
#endif
