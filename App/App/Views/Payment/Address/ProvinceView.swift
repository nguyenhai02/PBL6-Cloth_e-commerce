//
//  ProvinceView.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import SwiftUI

struct ProvinceView: View, Hashable {
    static func == (lhs: ProvinceView, rhs: ProvinceView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) { }
    
    @State var selectedProvince: Province? = nil
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: AddressViewModel
    
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Spacer().frame(height: 18)
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
                    Text("Chọn Tỉnh")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                }
                Spacer().frame(height: 35)
                Text("Tỉnh/ Thành phố")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 15)
                Spacer().frame(height: 10)
                List(viewModel.addresses, id: \.code) { province in
                    HStack {
                        Text(province.name)
                        Spacer()
                        if selectedProvince?.code == province.code {
                            Image(systemName: "checkmark")
                                .foregroundColor(.red)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                            if selectedProvince?.code == province.code {
                                selectedProvince = nil
                            } else {
                                selectedProvince = province
                                viewModel.city = province.name
                                path.append(DistrictView(path: $path, viewModel: viewModel))
                                print( viewModel.city)
                            }
                    }
                }
                .listStyle(.plain)
                .background(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: DistrictView.self) { _ in
            DistrictView(path: $path, viewModel: viewModel)
        }
        .onAppear {
            viewModel.getAddressFromURL()
        }
    }
}




struct ProvinceView_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceView(path: .constant(NavigationPath()), viewModel: AddressViewModel())
    }
}
