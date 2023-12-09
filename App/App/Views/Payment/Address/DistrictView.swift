//
//  DistrictView.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import SwiftUI

struct DistrictView: View, Hashable {
    static func == (lhs: DistrictView, rhs: DistrictView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @State var selectedDistrict: District? = nil
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
                    Text("Chọn Quận/ Huyện")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                }
                Spacer().frame(height: 35)
                Text("Quận/ Huyện")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 15)
                Spacer().frame(height: 10)
                List(viewModel.addresses.first(where: { p in
                    p.name == viewModel.city
                })?.districts ?? [], id: \.self) { district in
                    HStack {
                        Text("\(district.name)")
                        Spacer()
                        if selectedDistrict?.code == district.code {
                            Image(systemName: "checkmark")
                                .foregroundColor(.red)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                            selectedDistrict = district
                        viewModel.district = district.name
                        path.append(WardView(path: $path, viewModel: viewModel))
                            print( viewModel.district)
                    }
                }
                .listStyle(.plain)
                .background(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: WardView.self) {_ in 
            WardView(path: $path, viewModel: viewModel)
        }
    }
}


struct DistrictView_Previews: PreviewProvider {
    static var previews: some View {
        DistrictView(path: .constant(NavigationPath()), viewModel: AddressViewModel())
    }
}
