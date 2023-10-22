//
//  ChooseAddressView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI
import RadioGroup
import RadioButton

struct ChooseAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    @State var showAddAddress = false
    @State var isSelected: Int = 0
    @State var value: Int = 0
    
   
    
    var body: some View {
        ZStack {
            Color("E1E2E7")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 20)
                HStack(spacing: 0) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .padding(.leading, 25)
                    }
                    Text("Địa chỉ của tôi")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                    Button(action: {
                        self.showAddAddress = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .padding(.trailing, 25)
                    }
                }
                Spacer().frame(height: 30)
                ScrollView {
                    ForEach(1..<5) { index in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                
                                Text("Nguyễn Thị Thanh Hiền")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17))
                                Rectangle()
                                    .frame(width: 1, height: 15)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                                    .padding(.leading, 10)
                                Text("0582435733")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 20)
                            Text("1000 Nguyễn Khánh Toàn")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.top, 5)
                            Text("Phường Hoà Cường Bắc, Hải châu, Đà Nẵng")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.top, 5)
                                .padding(.bottom, 15)
                            Divider()
                                .padding(.horizontal, 30)
                            
                        }
                        .padding(.leading, 20)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showAddAddress) {
                AddAddressView(path: $path)
            }
        }
    }
}

struct ChooseAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAddressView(path: .constant(NavigationPath()))
    }
}
