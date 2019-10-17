//
//  PrimaryButton.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct DecideButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 240, height: 48, alignment: .center)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(6)
    }
}

extension Text {
    func decideButton() -> Text {
        font(Font.system(size: 24))
            .fontWeight(.semibold)
    }
}

#if DEBUG
struct DecideButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            print("Pressed")
        }) {
            Text("PrimaryButton").decideButton()
        }
        .modifier(DecideButtonModifier())
    }
}
#endif
