//
//  HUD.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine

public enum HUDAppearanceType {
    case hide
    case show
}
struct HUDAnimator: EnvironmentKey {
    static var defaultValue: Value = .show
    
    typealias Value = HUDAppearanceType
}

struct HUD : UIViewRepresentable {
    static var counter: Int = 0
    
    func makeUIView(context: UIViewRepresentableContext<HUD>) -> UIActivityIndicatorView {
        let view: UIViewType = UIActivityIndicatorView(style: .medium)
        view.color = .black
        view.hidesWhenStopped = true
        view.center = Optional(UIScreen.main.bounds.origin).map { CGPoint(x: $0.x / 2, y: $0.y / 2) }!
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<HUD>) {
        switch context.environment[HUDAnimator.self] {
    case .show:
        HUD.counter += 1
    case .hide:
        HUD.counter -= 1
        }
        
        assert(HUD.counter >= 0)
        
        switch HUD.counter {
        case 0:
            uiView.stopAnimating()
        case _:
            uiView.startAnimating()
        }
    }
    
    typealias UIViewType = UIActivityIndicatorView
}
#if DEBUG
struct HUD_Previews : PreviewProvider {
    static var previews: some View {
        HUD()
    }
}
#endif
