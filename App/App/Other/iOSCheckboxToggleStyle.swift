//
//  iOSCheckboxToggleStyle.swift
//  App
//
//  Created by Thanh Hien on 19/10/2023.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
                configuration.label
            }
        })
    }
}
