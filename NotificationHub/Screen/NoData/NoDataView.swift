//
//  NoDataView.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct NoDataView: View {
    let message: String
    var body: some View {
        Text(message)
            .font(Font.system(size: 42))
            .fontWeight(.bold)
    }
}

#if DEBUG
struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(message: "No Data")
    }
}
#endif
