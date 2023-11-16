//
//  WardView.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import SwiftUI

struct WardView: View, Hashable {
    static func == (lhs: WardView, rhs: WardView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @State var selectedWard: Ward? = nil
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
                    Text("Chọn Phường/ Xã")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                }
                Spacer().frame(height: 35)
                Text("Phường/ Xã")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 15)
                Spacer().frame(height: 10)
                List(viewModel.addresses.first(where: { p in
                    p.name == viewModel.city
                })?.districts?.first(where: {d in
                    d.name == viewModel.district
                })?.wards ?? [], id: \.self) { ward in
                    HStack {
                        Text("\(ward.name)")
                        Spacer()
                        if selectedWard?.code == ward.code {
                            Image(systemName: "checkmark")
                                .foregroundColor(.red)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedWard = ward
                        viewModel.ward = ward.name
                        path.removeLast(3)
                            print( viewModel.ward)
                    }
                }
                .listStyle(.plain)
                .background(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct WardView_Previews: PreviewProvider {
    static var previews: some View {
        WardView(path: .constant(NavigationPath()), viewModel: AddressViewModel())
    }
}
