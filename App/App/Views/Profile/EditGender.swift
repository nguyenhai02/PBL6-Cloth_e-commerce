//
//  EditGender.swift
//  App
//
//  Created by Thanh Hien on 28/10/2023.
//

import SwiftUI

struct EditGender: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Binding var path: NavigationPath
    @State var isselected: Gender = .UNSPECIFIED
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Text("Giới tính")
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    Spacer()
                }
                ForEach(Gender.allCases, id: \.self) { gender in
                    Button(action: {
                        isselected = gender
                        viewModel.gender = "\(gender)"
                        viewModel.updateProfile()
                        path.removeLast()
                    }) {
                        HStack {
                            Text(gender.rawValue)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                                .font(.system(size: 14))
                            Spacer()
//                            if isselected == index {
//                                Image(systemName: "checkmark")
//                                    .foregroundColor(.blue)
//                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            .padding()
            .frame(width: 300, height: 150)
            .background(.white)
            .padding(.bottom, 100)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EditGender_Previews: PreviewProvider {
    static var previews: some View {
        EditGender(path: .constant(NavigationPath()))
    }
}
