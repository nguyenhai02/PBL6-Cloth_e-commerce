//
//  AddAddressView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct AddAddressView: View {
    @State var name: String = ""
    @State var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    @FocusState var isNameFocused: Bool
    @FocusState var isPhoneFocused: Bool
    @FocusState var isCityFocused: Bool
    @FocusState var isAddressFocused: Bool
    @FocusState var isStateFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading)  {
            Spacer().frame(height: 20)
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 25)
                }
                Text("Địa chỉ mới")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 40)
            ButtonView(title: "Name", text: name, isFocused: _isNameFocused)
            ButtonView(title: "Phone number", text: name, isFocused: _isPhoneFocused)
            ButtonView(title: "Street Address", text: name, isFocused: _isAddressFocused)
            ButtonView(title: "City", text: name, isFocused: _isCityFocused)
            ButtonView(title: "State/Province/Region", text: name, isFocused: _isStateFocused)
            HStack(spacing: 20) {
                Button(action: {
                    // action
                }) {
                    Text("Delete")
                        .foregroundColor(.black)
                        .padding(10)
                        .frame(width: 160, height: 42)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8).stroke(.gray))
                }
                Button(action: {
                    // action
                }) {
                    Text("Add Address")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: 160, height: 42)
                        
                }
                .background(Color("002482"))
                .cornerRadius(8)
            }
           
            .padding(.horizontal, 35)
            .padding(.top, 30)
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ButtonView: View {
    @State var title: String
    @State var text: String
    @FocusState var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(Color("002482"))
                .fontWeight(.medium)
                .padding(.top, 5)
            TextField("", text: $text)
                .frame(height: 48)
                .padding(.leading, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color("002482") : Color("E1E2E7"), lineWidth: 1))
                .autocapitalization(UITextAutocapitalizationType.none)
                .focused($isFocused)
                .padding(.top, 10)
        }
        .padding(.leading, 32)
        .padding(.trailing, 25)
    }
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView(path: .constant(NavigationPath()))
    }
}
