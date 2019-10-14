//
//  PageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

final class NotificationListPageViewStore: ObservableObject {
    static let shared = NotificationListPageViewStore()

    private let subject = CurrentValueSubject<NotificationPageState?, Never>(nil)
    private var canceller: Set<AnyCancellable> = []
    
    @Published var pages: [NotificationListView] = []
    private init() {
        bind()
    }
    
    func bind() {
        sharedStore
            .objectWillChange
            .map { sharedStore.state.notificationPageState }
            .sink { [weak self] (state) in self?.subject.value = state }
            .store(in: &canceller)
        
        subject
            .removeDuplicates(by: { $0?.notificationsStatuses.count == $1?.notificationsStatuses.count })
            .filter { $0 != nil }
            .map { state in
                state!.notificationsStatuses
                    .filter { $0.isVisible }
                    .map { NotificationListView(watching: $0.watching) }
        }
        .assign(to: \.pages, on: self)
        .store(in: &canceller)
        
    }
}

struct NotificationListPageView: View {
    @ObservedObject var store: NotificationListPageViewStore = .shared
    var currentPage: Binding<Int> {
        Binding<Int>(
            get: { sharedStore.state.notificationPageState.currentNotificationPage },
            set: { sharedStore.dispatch(action: ChangeNotificationPageAction(page: $0)) })
    }
    
//    var pages: [NotificationListView] {
//        sharedStore
//            .state
//            .notificationPageState
//            .notificationsStatuses
//            .map { _ in
//                NotificationListView()
//        }
//    }
//
    var body: some View {
        PageView(views: store.pages, currentPage: currentPage)
    }
}

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var currentPage: Binding<Int>

    init(views: [Page], currentPage: Binding<Int>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self.currentPage = currentPage
    }

    var body: some View {
        PageViewController(
            viewControllers: viewControllers,
            currentPage: currentPage
        )
    }
}

#if DEBUG
struct PageView_Preview: PreviewProvider {
    @State static var currentPage: Int = 0
    static var previews: some View {
        PageView(views: [EmptyView()], currentPage: $currentPage)
    }
}
#endif
