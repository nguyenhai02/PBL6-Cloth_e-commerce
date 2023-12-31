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
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
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
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                }
                Spacer().frame(height: 15)
                Divider().background(Color("E1E2E7").opacity(0.7)).shadow(radius: 1)
                VStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        viewModel.showProfile()
                    }) {
                        PhotosPicker(selection: $pickerImageViewModel.imageSelection, matching: .images) {
                            VStack() {
                                ZStack(alignment: .bottom) {
                                    if let image = pickerImageViewModel.selectedImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width, height: 240)
                                            .clipped()
                                        
                                    } else {
                                        KFImage(URL(string: viewModel.profile?.avatar ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                                            .cacheOriginalImage()
                                            .onSuccess { r in
                                                print("suc: \(r)")
                                            }
                                            .onFailure { e in
                                                print("err: \(e)")
                                            }
                                            .placeholder {                                            ProgressView().frame(width: UIScreen.main.bounds.width, height: 240)
                                                    .border(Color.blue)
                                            }
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width, height: 240)
                                            .clipped()
//                                            .cornerRadius(50)
//                                            .shadow(radius: 5)
                                        
                                    }
                                    HStack {
                                        Spacer()
                                        Text("Chạm để thay đổi")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black.opacity(0.8))
//                                            .padding(.top, 220)
                                        Spacer()
                                    }
                                    .background(Color.gray.opacity(0.4))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 240)
                        }
                    }
                    Divider().background(Color("E1E2E7"))
                }
//                .background(Color("EBF0FF1"))
                VStack(spacing: 0) {
                    profileItem(icon: "name", title: "Tên", value: (viewModel.profile?.name ?? "")) {
                        path.append("EditNameView")
                    }
                    profileItem(icon: "smartphone", title: "Số điện thoai", value: viewModel.profile?.phone ?? "") {
                        path.append("EditPhoneView")
                    }
                    ForEach(Gender.allCases, id: \.self) { gender in
                        if viewModel.profile?.gender == "\(gender)" {
                            profileItem(icon: "gender", title: "Giới tính", value: "\(gender.rawValue)") {
                                path.append("EditGender")
                            }
                        }
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
