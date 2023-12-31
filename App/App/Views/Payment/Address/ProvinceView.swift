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
    @State var searchText: String = ""
    
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
                    HStack {
                        TextField("Tìm kiếm...", text: $searchText)
                            .padding([.leading], 10)
                            .foregroundColor(.black)
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        Button(action: {
                            viewModel.searchCity(name: searchText)
                            print(searchText)
                            print(viewModel.cities)
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(10)
                        
                    }
                    .frame(width: 300 , height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(Color.black.opacity(0.8).opacity(0.5))).shadow(radius: 0)
                        .background(.white)
                        .padding([.leading], 10)
                        .padding(.trailing, 20)
                    Spacer()
                }
                Spacer().frame(height: 25)
                Text("Tỉnh/ Thành phố")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 15)
                Spacer().frame(height: 10)
                if viewModel.citiesSearch == [] {
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
                                print("iewModel.cit")
                                print(viewModel.city)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .background(.white)
                } else {
                    List(viewModel.citiesSearch, id: \.code) { province in
                        HStack {
                            Text(province.name)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedProvince?.code == province.code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.red)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                                selectedProvince = province
                                viewModel.city = province.name
                                path.append(DistrictView(path: $path, viewModel: viewModel))
                            viewModel.citiesSearch = []
                                print( viewModel.city)
                        }
                    }
                    .listStyle(.plain)
                    .background(.white)
            }
        }
    }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: DistrictView.self) { _ in
            DistrictView(path: $path, viewModel: viewModel)
        }
    }
}




struct ProvinceView_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceView(path: .constant(NavigationPath()), viewModel: AddressViewModel())
    }
}
