//
//  BarButtonImageModifier.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

extension Image {
    func barButtonItems() -> some View {
        renderingMode(.template)
            .foregroundColor(.primary)
            .modifier(BarButtonImageModifier())
    }
}

struct BarButtonImageModifier: ViewModifier {
    let edge: CGFloat = 44
    
    func body(content: Content) -> some View {
        content
            .frame(width: edge, height: edge, alignment: .center)
    }
}

#if DEBUG
struct BarButtonImageModifier_Previews : PreviewProvider {
    static var previews: some View {
        Image(systemName: "person")
            .barButtonItems()
    }
}
#endif
