//
//  CartView.swift
//  App
//
//  Created by Thanh Hien on 17/10/2023.
//

import SwiftUI

struct CartView: View {
    @Binding var path: NavigationPath
    @State var value = 0
    @State private var isOn = false
    @State var items: [Int] = Array(1..<20)
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My cart")
                .bold()
                .frame(maxWidth: .infinity)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding([.top, .leading], 20)
            Spacer().frame(height: 10)
            ScrollView {
                ForEach(items, id: \.self) { index in
                    HStack(spacing: 0) {
                        Button(action: {
                        }) {
                            Image("xinh")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 120)
                                .cornerRadius(1)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack   {
                                Text("Wine Halter Bow Skater ")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("002482"))
                                    .lineLimit(1)
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                        .frame(width: 18, height: 18)
                                }
                            }
                            Text("Wine Halter Bow")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            HStack {
                                Text("Color:")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                Text("Đỏ")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.7))
                                
                                Text("Size:")  .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Text("S")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.7))
                            }
                            .padding(.top, 10)
                            HStack(spacing: 0) {
                                Button(action: {
                                    if value > 0 {
                                        value -= 1
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .frame(width: 32, height: 20)
                                        .padding(1)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                                }
                                Text("\(value)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .frame(width: 32, height: 20)
                                    .padding(1)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                                    .background(Color("EBF0FF"))
                                Button(action: {
                                    value += 1
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .frame(width: 28, height: 18)
                                        .padding(1)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                                }
                            }
                            .padding([.top,.bottom], 10)
                            Divider().shadow(radius: 1)
                        }
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        .multilineTextAlignment(.leading)
                    }
                    .padding([.trailing, .leading], 20)
                }
            }
            Spacer()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(path: .constant(NavigationPath()))
    }
}
