//
//  ProfileView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI
import PhotosUI

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @ObservedObject var pickerImageViewModel = PhotoPickerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 15)
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("left")
                        .padding(.leading, 15)
                }
                Text("Your Account")
                    .font(.system(size: 22))
                    .foregroundColor(Color("002482"))
                    .padding(.leading, 15)
                    .padding(.bottom, 15)
            }
            Divider().background(Color("E1E2E7"))
            Button(action: {
            }) {
                VStack() {
                    ZStack() {
                        if let image = pickerImageViewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image("product")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(Circle())
                            
                        }
                    }
                    PhotosPicker(selection: $pickerImageViewModel.imageSelection, matching: .images) {
                        Text("Choose Image")
                    }
                }
            }
//            .frame(minWidth: .infinity, alignment: .center)
            .padding(.top, 30)
            .padding(.leading, 140)
            .padding(.bottom, 20)
            Divider().background(Color("E1E2E7"))
//            Spacer().frame(height: 10)
            profileItem(icon: "person", title: "Name", value: viewModel.profile?.name ?? "")
            //            profileItem(icon: "gender", title: "Gender", value: viewModel.profile?.gender ?? "")
            profileItem(icon: "email", title: "Email", value: viewModel.profile?.email ?? "")
            profileItem(icon: "smartphone", title: "Phone", value: viewModel.profile?.phone ?? "")
            profileItem(icon: "changePassword", title: "Change password", value: "")
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func profileItem(icon: String, title: String, value: String) -> some View {
        HStack {
            Button(action: {
                // Action
            }) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(Color("002482"))
                    .padding(.leading, 10)
                Spacer()
                Text(value)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                Image("rightlight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .padding(.trailing, 20)
            }
        }
        .padding([.top, .leading], 30)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(path: .constant(NavigationPath()))
    }
}
