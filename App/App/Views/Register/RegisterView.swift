//
//  RegisterView.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 35)
                Group {
                    Text("Lets Register Account")
                        .font(.system(size: 28))
                        .foregroundColor(Color("4A3AFF"))
                        .bold()
                    Text("Hello user , you have a greatful journey")
                        .font(.system(size: 28))
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                }
                .frame(maxWidth: .infinity)
                Spacer().frame(height: 35)
                Group {
                    TLTextField(title: "First name", color: Color("4A3AFF"), text: $viewModel.firstName)
                    TLTextField(title: "Last name", color: Color("4A3AFF"), text: $viewModel.lastName)
                    TLTextField(title: "Phone", color: Color("4A3AFF"), text: $viewModel.phone)
                    TLTextField(title: "Email", color: Color("4A3AFF"), text: $viewModel.email)
                    TLTextField(title: "Password", color: Color("4A3AFF"), text: $viewModel.password)
                    
                    Spacer().frame(height: 30)
                    TLButton(title: "Sign up", background: Color("4A3AFF"), action: {
                    })
                }
                .padding([.leading, .trailing], 22)
                HStack {
                    Text("Already  have an account ?")
                        .foregroundColor(.gray)
                    NavigationLink("Login", destination: LoginView())
                        .foregroundColor(.black)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 25)
                Spacer()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
