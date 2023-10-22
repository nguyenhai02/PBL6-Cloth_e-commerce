//
//  TLTextField.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct TLTextField: View {
    let title: String
    let color: Color
    let imageURL: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    var onTextChange: ((String) -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .leading) {
                    Image("\(imageURL)")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding([.leading,.trailing], 12)
                   TextField("Enter \(title.lowercased())", text: $text)
                       .padding(.leading, 50)
                       .frame(height: 48)
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(isFocused ? color : Color("E1E2E7"), lineWidth: 1)
                       )
                       .autocapitalization(UITextAutocapitalizationType.none)
                       .focused($isFocused) // Sử dụng .focused với FocusState
                       .padding(.top, 2)
                       .onChange(of: text) { newValue in
                           onTextChange?(newValue)
                       }
            
               }
        .padding(.top, 10)
    }
}

struct TLTextField_Previews: PreviewProvider {
    static var previews: some View {
        TLTextField(title: "Email", color: .green.opacity(0.3), imageURL: "message", text: .constant(""))
    }
}
