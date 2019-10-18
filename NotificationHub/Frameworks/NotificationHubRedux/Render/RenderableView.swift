//
//  RenderView.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

// Awesome reference: https://github.com/Dimillian/SwiftUIFlux/blob/master/Sources/SwiftUIFlux/connector/
public protocol RenderableView: View {
    associatedtype State: ReduxState
    associatedtype Props
    associatedtype V: View
    
    func map(state: State, dispatch: @escaping DispatchFunction) -> Props
    func body(props: Props) -> V
}

public extension RenderableView {
    func render(state: State, dispatch: @escaping DispatchFunction) -> V {
        let props = map(state: state, dispatch: dispatch)
        return body(props: props)
    }
    
    var body: StoreConnector<State, V> {
        return StoreConnector(content: render)
    }
}

public struct StoreConnector<State: ReduxState, V: View>: View {
    @EnvironmentObject var store: Store<State>
    let content: (State, @escaping (Action) -> Void) -> V
    
    public var body: V {
        content(store.state, store.dispatch(action:))
    }
}

public struct StoreProvider<S: ReduxState, V: View>: View {
    public let store: Store<S>
    public let content: () -> V
    
    public init(store: Store<S>, content: @escaping () -> V) {
        self.store = store
        self.content = content
    }
    
    public var body: some View {
        content().environmentObject(store)
    }
}
