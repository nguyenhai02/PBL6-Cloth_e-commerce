//
//  ChooseAddressView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct ChooseAddressView: View, Hashable {
    static func == (lhs: ChooseAddressView, rhs: ChooseAddressView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    
    @ObservedObject var viewModel: AddressViewModel
    @Binding var path: NavigationPath
    @State var isSelected: Int = 0
    @State var value: Int = 0
    
    
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 20)
                HStack(spacing: 0) {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .padding(.leading, 25)
                    }
                    Text("Địa chỉ của tôi")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                }
                Spacer().frame(height: 15)
                ScrollView {
                    RadioAddressGroup(path: $path, selection: 0, viewModel: viewModel) {
                        path.removeLast()
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.getAddress()
            }
        }
    }
}

struct ChooseAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAddressView(viewModel: AddressViewModel(), path: .constant(NavigationPath()))
    }
}
