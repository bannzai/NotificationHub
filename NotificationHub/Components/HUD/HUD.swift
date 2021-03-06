//
//  HUD.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import NotificationHubRedux

public enum HUDAppearanceType: Int, Equatable {
    case hide
    case show
}

struct IndicatorView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<IndicatorView>) -> UIActivityIndicatorView {
        let view: UIViewType = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.center = Optional(UIScreen.main.bounds.origin).map { CGPoint(x: $0.x / 2, y: $0.y / 2) }!
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<IndicatorView>) {

    }
    
    typealias UIViewType = UIActivityIndicatorView
}

struct HUD: View {
    @EnvironmentObject var store: Store<AppState>
    var body: some View {
        Group {
            if store.state.hudState.current == .show {
                IndicatorView()
            } else {
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct HUD_Previews : PreviewProvider {
    static var previews: some View {
        HUD()
    }
}
#endif
