//
//  SearchBar.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/16.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct SearchBar : View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            textField()
            Button(
                action: { self.cancel() },
                label: { Text("Cancel") }
                )
                .foregroundColor(Color.gray)
        }
    }
    
    private func cancel() {
        endEditing()
    }
    
    private func textField() -> some View {
        TextField($text, placeholder: Text("Search text"))
            .padding()
            .frame(height: 44)
            .background(Color.white.opacity(0.8))
            .border(Color.black, width: 1, cornerRadius: 8)
    }
}


// FIXME: Can not pass required value
//#if DEBUG
//struct SearchBar_Previews : PreviewProvider {
//    static var previews: some View {
//        SearchBar(text: "")
//    }
//}
//#endif
