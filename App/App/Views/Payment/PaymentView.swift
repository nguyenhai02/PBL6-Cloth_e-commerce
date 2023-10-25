//
//  PaymentView.swift
//  App
//
//  Created by Thanh Hien on 24/10/2023.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    let item: ItemAddress
    let product: Product
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 18)
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 25)
                }
                Text("Thanh toán")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 14)
            Divider().background(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 0).stroke(Color.gray.opacity(0.1), lineWidth: 1)
                ).shadow(radius: 2)
            ScrollView {
                Spacer().frame(height: 12)
                Button(action: {
                    
                }) {
                    HStack {
                        VStack {
                            Image("address2")
                                .resizable()
                                .frame(width: 14, height: 20)
                            Spacer()
                        }
                        //                            .padding(.top, 25)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Địa chỉ nhận hàng")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                            HStack(spacing: 0) {
                                Text(item.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                                    .lineLimit(1)
                                Rectangle()
                                    .frame(width: 1, height: 14)
                                    .foregroundColor(.black)
                                    .padding(.leading, 8)
                                Text(item.phone)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .padding(.leading, 6)
                                    .lineLimit(1)
                            }
                            .padding(.top, 8)
                            Text(item.address)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text(item.contries)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 10)
                        Spacer()
                        Image("rightlight")
                            .padding(.trailing, 10)
                    }
                    .padding(.leading, 20)
                }
                //                Divider().background(.black).shadow(radius: 10)
                Spacer().frame(height: 25)
                HStack {
                    Image("xinh")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(product.name)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .padding(.top, 10)
                        HStack(spacing: 0) {
                            Text("đ\((product.price) - ((product.price) * (product.discount) / 100))")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("x1")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .padding(.trailing, 15)
                        }
                        .padding(.top, 40)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    //                    Spacer()
                }
                .padding(.leading, 25)
                .padding(.vertical, 5)
                .background(Color("E1E2E7").opacity(0.5))
                //                Divider().background(Color("E1E2E7")).shadow(radius: 1)
                Spacer().frame(height: 25)
                HStack {
                    Text("Tổng số tiền:")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Text("đ200000")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                        .padding(.trailing, 15)
                }
                .padding(.leading, 20)
                Spacer().frame(height: 20)
                Divider().background(Color("E1E2E7"))
                Button(action: {
                    
                }) {
                    HStack {
                        Text("Phương phức thanh toán")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        Text("Momo")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Image(systemName: "greaterthan")
                            .resizable()
                            .foregroundColor(.black.opacity(0.8))
                            .frame(width: 8, height: 12)
                            .padding(.trailing, 12)
                            .padding(.leading, 5)
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
            }
            Divider().background(Color("E1E2E7"))
            HStack(spacing: 0) {
                Spacer()
                Button(action:  {
                    
                }) {
                    VStack(spacing: 0) {
                        Text("Tổng thanh toán")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Text("đ128000")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                    }
                }
                .frame(height: 52)
                .padding(.leading, 100)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Đặt Hàng")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 52)
                .background(Color("002482").opacity(0.9))
            }
            Divider().background(Color("E1E2E7"))
            Spacer().frame(height: 8)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(path: .constant(NavigationPath()), item: ItemAddress(name: "Nguyen thi Thanh Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), product: Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")))
    }
}
