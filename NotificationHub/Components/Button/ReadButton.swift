//
//  ReadButton.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/08.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct ReadButton: View {
    let pressed: () -> Void
    
    let edge: CGFloat = 44
    var body: some View {
        Button(action: {
            self.pressed()
        }) {
            Image(systemName: "eye.fill")
                .renderingMode(.template)
                .foregroundColor(.primary)
        }.frame(width: edge, height: edge, alignment: .center)
    }
}


struct ReadButton_Previews: PreviewProvider {
    @State static var read: Bool = false
    static var previews: some View {
        ReadButton {
            print("Pressed")
        }
    }
}
