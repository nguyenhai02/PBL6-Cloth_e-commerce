//
//  TLTextField.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct TLTextField: View {
    var title: String
    let color: Color
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
                   TextField("Your \(title.lowercased())", text: $text)
                       .padding(.leading, 16)
                       .frame(height: 52)
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(isFocused ? color : Color.gray, lineWidth: 1)
                       )
                       .focused($isFocused) // Sử dụng .focused với FocusState
               }
        .padding(.top, 15)
    }
}

struct TLTextField_Previews: PreviewProvider {
    static var previews: some View {
        TLTextField(title: "Email", color: .green.opacity(0.3), text: .constant(""))
    }
}
