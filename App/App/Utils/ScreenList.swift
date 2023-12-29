//
//  ScreenList.swift
//  App
//
//  Created by Thanh Hien on 26/10/2023.
//

import SwiftUI

@ViewBuilder
func getScreen(id: String, path: Binding<NavigationPath>) -> some View{
    switch(id){
    case "TagBarView":
        TagBarView(path: path)
    case "LoginView":
        LoginView(path: path)
    case "FavoriteView":
        FavoriteView(path: path)
    case "ProfileView":
        ProfileView(path: path)
    case "AddAddressView":
        AddAddressView(path: path)
    case "ForgotPasswordView":
        ForgotPasswordView(path: path)
    case "RegisterView":
        RegisterView(path: path)
    case "EditNameView":
        EditNameView(path: path)
    case "EditPhoneView":
        EditPhoneView(path: path)
    case "EditGender":
        EditGender(path: path)
    case "MyOrdersView":
        MyOrdersView(path: path)
    case "TransferMoneyView":
        TransferMoneyView(path: path)
    case "SuccessCODView":
        SuccessCODView(path: path)
    case "SuccessView":
        SuccessView(path: path)
    default:
        Text("screen is developing")
    }
}
