//
//  ReadButton.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/08.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct ReadButton: View {
    @Binding var read: Bool
    
    let edge: CGFloat = 44
    var body: some View {
        Button(action: {
            self.read.toggle()
        }) {
            if read {
                Image(systemName: "eye")
            } else {
                Image(systemName: "eye.fill")
            }
        }.frame(width: edge, height: edge, alignment: .center)
    }
}


struct ReadButton_Previews: PreviewProvider {
    @State static var read: Bool = false
    static var previews: some View {
        ReadButton(read: $read)
    }
}
