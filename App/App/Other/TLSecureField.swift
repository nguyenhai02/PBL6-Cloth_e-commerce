//
//  TLSecureField.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import Foundation
import SwiftUI

struct TLSecureField: View {
    var title: String
    let color: Color
    let imageURL: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
                    Image("\(imageURL)")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding([.leading,.trailing], 12)
                   SecureField("Enter \(title.lowercased())", text: $text)
                       .padding(.leading, 50)
                       .frame(height: 48)
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(isFocused ? color : Color("E1E2E7"), lineWidth: 1)
                       )
                       .focused($isFocused)
                       .padding(.top, 2)
            
               }
        .padding(.top, 10)
    }
}

struct TLSecureField_Previews: PreviewProvider {
    static var previews: some View {
        TLSecureField(title: "password", color: .green.opacity(0.3), imageURL: "password", text: .constant(""))
    }
}
