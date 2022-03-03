//
//  CheckBoxView.swift
//  ios-swift-start
//
//  Created by alopezh on 04/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Button(action: {}) {
            RoundedRectangle(cornerRadius: 10)
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: .constant(false))
    }
}
