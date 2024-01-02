//
//  MyOrdersView.swift
//  App
//
//  Created by Thanh Hien on 06/11/2023.
//

import Foundation
import SwiftUI

struct MyOrdersView: View {
    @ObservedObject var viewModel = OrderViewModel()
    @State private var selectorIndex = 0
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack(alignment: .trailing){
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 15)
                NavigationBarView()
                Spacer().frame(height: 15)
//                Divider()
                HStack(alignment: .center, spacing: 40){
                    Spacer()
                    Button(action: {
                        selectorIndex = 0
                    }) {
                        VStack {
                            Image("box")
                                .resizable()
                                .frame(width: 22, height: 22)
                            Text("Chưa thanh toán")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                        }
                    }
                    Button(action: {
                        selectorIndex = 1
                    }) {
                        VStack {
                            Image("delivery")
                                .resizable()
                                .frame(width: 22, height: 22)
                            Text("Đã thanh toán")
                                .fontWeight(.medium)
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                            //                                .padding(.top, 5)
                        }
                    }
                    Button(action: {
                        selectorIndex = 2
                    }) {
                        VStack {
                            Image("shipped")
                                .resizable()
                                .frame(width: 22, height: 22)
                            Text("Đã bị huỷ")
                                .fontWeight(.medium)
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                            //                                .padding(.top, 5)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 15)
                Divider()
                if selectorIndex == 0 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 10) {
                            ForEach(viewModel.orders.filter { $0.order.status == "UN-COMPLETE" }, id: \.self) { order in
                                OrderRow(order: order, selectorIndex: self.selectorIndex)
                            }
                        }
                        .padding(.horizontal, 15)
                    })
                } else if selectorIndex == 1 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 10) {
                            ForEach(viewModel.orders.filter { $0.order.status == "COMPLETE" }, id: \.self) { order in
                                OrderRow(order: order, selectorIndex: self.selectorIndex)
                            }
                        }
                        .padding(.horizontal, 15)
                    })
                } else if selectorIndex == 2 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 10) {
                            ForEach(viewModel.orders.filter { $0.order.status == "CANCELLED" }, id: \.self) { order in
                                OrderRow(order: order, selectorIndex: self.selectorIndex)
                            }
                        }
                        .padding(.horizontal, 15)
                    })
                }
                //                else {
                //                    ScrollView(.vertical, showsIndicators: false, content: {
                //                        VStack(spacing: 10) {
                //                            ForEach(self.arrOrder.filter { $0.status == "Cancelled" }, id: \.id) { order in
                //                                OrderRow(order: order, selectorIndex: self.selectorIndex)
                //                            }
                //                        }
                //                        .padding(.horizontal, 15)
                //                    })
                //                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.getAllOders()
            }
        }
    }
}

struct OrderRow: View {
    var order: OrderResponse
    var selectorIndex = 0
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Mã đơn hàng: \(order.order.id)")
                    .foregroundColor(.black)
                Spacer()
                Text(order.order.orderDate)
                    .foregroundColor(.gray)
            }.padding([.top], 2)
            VStack {
                ForEach(order.orderItems, id: \.self) { orderItem in
                    DetailOrder(image: orderItem.product.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg", name: orderItem.product.name, price: orderItem.product.price, quantity: orderItem.quantity, color: orderItem.productVariant.color, size: orderItem.productVariant.size)
                }
//                Text("Quantity:")
//                Text("\(order.quantity)")
//                    .foregroundColor(.gray)
//                Spacer()
                Divider()
                HStack {
                    Text("Tổng tiền:")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Int(order.order.totalPrice))")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        
                }
            }.padding([.top], 2)
//                .padding(.h)
//            if self.selectorIndex == 0 {
//                Text(order.status)
//                    .foregroundColor(.green)
//                    .padding(.vertical, 1)
//            } else if self.selectorIndex == 1 {
//                Text(order.status)
//                    .foregroundColor(Color.gray)
//                    .padding(.vertical, 1)
//            } else {
//                Text(order.status)
//                    .foregroundColor(.red)
//                    .padding(.vertical, 1)
//            }
        }.font(.footnote)
        RoundedRectangle(cornerRadius: 0).stroke(Color("E1E2E7")).frame( height: 5).background(Color("E1E2E7"))
    }
}
extension MyOrdersView {
    func NavigationBarView() -> some View {
        return HStack {
            Button(action: {
                path.removeLast(1)
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 18, height: 18)
                    .padding(.leading, 25)
            }
            Text("Đơn mua")
                .foregroundColor(.black)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .padding(.leading, 15)
            Spacer()
        }
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersView(path: .constant(NavigationPath()))
    }
}
