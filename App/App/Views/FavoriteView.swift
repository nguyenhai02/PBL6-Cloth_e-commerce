//
//  FavoriteView.swift
//  App
//
//  Created by Thanh Hien on 17/10/2023.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 22, height: 18)
                        .padding(.leading, 25)
                    Text("Yêu thích")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 15)
            }
            Spacer().frame(height: 20)
            ScrollView {
                ForEach(1..<10) { _ in
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image("product")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72, height: 78)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Wine Halter Bow Skater Dress")
                                    .bold()
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("002482"))
                                    .lineLimit(2)
                                Text("Wine Halter Bow ")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .padding(.top, 5)
                                HStack {
                                    Text("VND: 100000")
                                        .font(.system(size: 10))
                                        .foregroundColor(.black)
                                    Text("80000")
                                        .font(.system(size: 10))
                                        .foregroundColor(.black)
                                    Text("\(20)% OFF")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                }
                                .padding(.top, 5)
                            }
                            .padding(.leading, 15)
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "multiply")
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.trailing, 10)
                            
                            Button(action: {
                            }) {
                                Image(systemName: "bag")
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    Divider()
                        .padding(.horizontal, 20)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(path: .constant(NavigationPath()))
    }
}


