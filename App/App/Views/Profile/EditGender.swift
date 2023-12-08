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
    let array: [String] = ["Male", "Female"]
    @State var isselected = 0
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Text("Giới tính")
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(0..<array.count, id: \.self) { index in
                    Button(action: {
                        isselected = index
                        viewModel.gender = array[index]
                        viewModel.updateProfile()
                        path.removeLast()
                    }) {
                        HStack {
                            Text(array[index])
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
