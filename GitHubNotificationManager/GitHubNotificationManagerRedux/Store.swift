//
//  Store.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final public class Store<State: ReduxState>: ObservableObject {
    @Published public var state: State

    private var dispatchFunction: DispatchFunction!
    private let reducer: Reducer<State>
    
    public init(
        reducer: @escaping Reducer<State>,
        middlewares: [Middleware<State>],
        state: State
    ) {
        self.reducer = reducer
        self.state = state
        
        self.dispatchFunction = middlewares
            .reversed()
            .reduce(
                { [unowned self] action in self.dispatchReduce(action: action) },
                { dispatchFunction, middleware in middleware(dispatcher(), lazyGetState())(dispatchFunction) }
        )
    }
    
    private func lazyGetState() -> () -> State? {
        return { [weak self] in
            self?.state
        }
    }
    
    private func dispatcher() -> (Action) -> Void {
        return { [weak self] action in
            self?.dispatch(action: action)
        }
    }
    
    public func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    private func dispatchReduce(action: Action) {
        state = reducer(state, action)
    }
}
