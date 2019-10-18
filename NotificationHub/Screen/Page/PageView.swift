//
//  PageView.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import NotificationHubCore
import NotificationHubData
import NotificationHubRedux

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
            .objectDidChange
            .map { sharedStore.state.notificationPageState }
            .sink { [weak self] (state) in self?.subject.value = state }
            .store(in: &canceller)
        
        let compareProperty: (NotificationPageState?) -> [WatchingElement?]? = {
            $0?.notificationsStatuses.filter { $0.isVisible }.map { $0.watching }
        }
        subject
            .receive(on: DispatchQueue.main)
            .removeDuplicates(by: { return compareProperty($0) == compareProperty($1) })
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
        PageView(views: store.pages)
    }
}

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]

    init(views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(
            viewControllers: viewControllers
        )
    }
}

struct PageView_Preview: PreviewProvider {
    @State static var currentPage: Int = 0
    static var previews: some View {
        PageView(views: [EmptyView()])
    }
}

