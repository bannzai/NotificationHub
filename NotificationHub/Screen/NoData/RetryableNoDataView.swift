//
//  RetryableNoDataView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct RetryableNoDataView: View {
    let message: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            NoDataView(message: message)
            Spacer()
            Button(action: action, label: {
                HStack {
                    Image(uiImage: UIImage(systemName: "goforward")!)
                    Text("Retry").decideButton()
                }
            })
            .modifier(DecideButtonModifier())
        }
        .frame(width: nil, height: 120, alignment: .center)
    }
}

#if DEBUG
struct RetryableNoDataView_Previews: PreviewProvider {
    static var previews: some View {
        RetryableNoDataView(message: "No Data", action: {
            print("Pressed")
        })
    }
}
#endif
