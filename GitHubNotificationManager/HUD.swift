//
//  HUD.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

public enum HUDCounterType: Int {
    case increment
    case decrement
}

struct HUDAnimator: EnvironmentKey {
    static var defaultValue: Value = .increment
    
    typealias Value = HUDCounterType
}

struct HUD : UIViewRepresentable {
    static var counter: Int = 0
    func makeUIView(context: UIViewRepresentableContext<HUD>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .black
        view.hidesWhenStopped = true
        view.center = Optional(UIScreen.main.bounds.origin).map { CGPoint(x: $0.x / 2, y: $0.y / 2) }!
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<HUD>) {
        switch context.environment[HUDAnimator.self] {
        case .increment:
            HUD.counter += 1
        case .decrement:
            HUD.counter -= 1
        }
        
        assert(HUD.counter > 0)
        
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
