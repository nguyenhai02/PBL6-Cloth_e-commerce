//
//  TLTextField.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI


struct EditTextView: View {
    var body: some View {
        VStack {
            TLTextField(title: "Email", color: .green.opacity(0.3), imageURL: "message", text: .constant(""))
            CustomTextFile(title: "Name", text: "name")
        }
    }
}

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
                        .foregroundColor(Color("323232"))
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

struct CustomTextFile: View {
    @State var title: String
    @State var text: String
    @FocusState var focused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13))
//                .foregroundColor(Color("002482"))
                .foregroundColor(.black.opacity(0.7))
                .fontWeight(.medium)
                .padding(.top, 5)
            TextField("", text: $text)
                .frame(height: 48)
                .padding(.leading, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(focused ? Color("002482") : Color("E1E2E7"), lineWidth: 1))
                .autocapitalization(UITextAutocapitalizationType.none)
                .focused($focused)
                .padding(.top, 6)
        }
        .padding(.horizontal, 30)
    }
}
struct TLTextField_Previews: PreviewProvider {
    static var previews: some View {
        EditTextView()
    }
}
