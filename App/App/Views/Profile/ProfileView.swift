//
//  ProfileView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @ObservedObject var pickerImageViewModel = PhotoPickerViewModel()
    
    @Binding var path: NavigationPath
    @State private var selectedGender: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 12)
            HStack {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 25)
                }
                Text("Xem hồ sơ")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
            }
            Spacer().frame(height: 30)
            Divider().background(Color("E1E2E7").opacity(0.7)).shadow(radius: 1)
            VStack(alignment: .center, spacing: 0) {
                Spacer().frame(height: 25)
                Button(action: {
                    viewModel.showProfile()
                }) {
                    PhotosPicker(selection: $pickerImageViewModel.imageSelection, matching: .images) {
                        VStack() {
                            ZStack() {
                                if let image = pickerImageViewModel.selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                } else {
                                    KFImage(URL(string: viewModel.profile?.avatar ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                                        .cacheOriginalImage()
                                        .onSuccess { r in
                                            print("suc: \(r)")
                                        }
                                        .onFailure { e in
                                            print("err: \(e)")
                                        }
                                        .placeholder {                                            ProgressView().frame(width: 100, height: 100)
                                                .border(Color.blue)
                                        }
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(50)
                                        .shadow(radius: 5)
                                    
                                }
                            }
                            Text("Edit photo")
                                .foregroundColor(Color("002482"))
                        }
                    }
                }
                .padding(.bottom, 25)
                Divider().background(Color("E1E2E7"))
            }
            .background(Color("EBF0FF1"))
            VStack(spacing: 0) {
                profileItem(icon: "name", title: "Tên", value: (viewModel.profile?.name ?? "")) {
                    path.append("EditNameView")
                }
                profileItem(icon: "smartphone", title: "Số điện thoai", value: viewModel.profile?.phone ?? "") {
                    path.append("EditPhoneView")
                }
                profileItem(icon: "gender", title: "Giới tính", value: viewModel.profile?.gender ?? "") {
                    path.append("EditGender")
                }
                //                profileItem(icon: "changePassword", title: "Change password", value: "") {
                //                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.showProfile()
            if let image = pickerImageViewModel.selectedImage {}
        }
    }
}

func profileItem(icon: String, title: String, value: String, completed: @escaping () -> Void) -> some View {
    VStack {
        HStack {
            Button(action: {
                completed()
            }) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color("002482"))
                    .padding(.leading, 5)
                Spacer()
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                Image("rightlight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .padding(.trailing, 12)
            }
            .padding(.leading, 15)
            .padding(.top, 20)
            .padding(.bottom, 10)
        }
        Divider().background(Color("E1E2E7"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(path: .constant(NavigationPath()))
    }
}
