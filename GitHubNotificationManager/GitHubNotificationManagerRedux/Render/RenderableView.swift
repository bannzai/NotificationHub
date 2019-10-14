//
//  RenderView.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

// Awesome reference: https://github.com/Dimillian/SwiftUIFlux/blob/master/Sources/SwiftUIFlux/connector/
public protocol RenderableView: View {
    associatedtype Props
    associatedtype V: View
    
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props
    func body(props: Props) -> V
}

public extension RenderableView {
    func render(state: AppState, dispatch: @escaping DispatchFunction) -> V {
        let props = map(state: state, dispatch: dispatch)
        return body(props: props)
    }
    
    var body: StoreConnector<V> {
        return StoreConnector(content: render)
    }
}

public struct StoreConnector<V: View>: View {
    @EnvironmentObject var store: Store
    let content: (AppState, @escaping (Action) -> Void) -> V
    
    public var body: V {
        content(store.state, store.dispatch(action:))
    }
}

public struct StoreProvider<V: View>: View {
    public let store: Store
    public let content: () -> V
    
    public init(store: Store, content: @escaping () -> V) {
        self.store = store
        self.content = content
    }
    
    public var body: some View {
        content().environmentObject(store)
    }
}
