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
            VStack {
                Spacer().frame(height: 15)
                NavigationBarView()
                Spacer().frame(height: 30)
                HStack(alignment: .center, spacing: 37){
                    Spacer()
                    Button(action: {
                        selectorIndex = 0
                    }) {
                        VStack {
//                            Image("waiting")
//                                .resizable()
//                                .frame(width: 24, height: 24)
                            Text("Chờ xác nhận")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
//                                .padding(.top, 5)
                        }
                    }
                    Button(action: {
                        selectorIndex = 1
                    }) {
                        VStack {
//                            Image("delivery")
//                                .resizable()
//                                .frame(width: 24, height: 24)
                            Text("Đã xác nhận")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
//                                .padding(.top, 5)
                        }
                    }
                    Button(action: {
                        selectorIndex = 2
                    }) {
                        VStack {
//                            Image("shipped")
//                                .resizable()
//                                .frame(width: 24, height: 24)
                            Text("Hoàn thành")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
//                                .padding(.top, 5)
                        }
                    }
                    Spacer()
                }
//                .padding(.leading, 25)
                Divider()
                if selectorIndex == 0 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 10) {
                            ForEach(viewModel.orders.filter { $0.status == "UN-COMPLETE" }, id: \.self) { order in
                                OrderRow(order: order, selectorIndex: self.selectorIndex)
                            }
                        }
                        .padding(.horizontal, 15)
                    })
                } else if selectorIndex == 1 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 10) {
                            ForEach(viewModel.orders.filter { $0.status == "COMPLETE" }, id: \.self) { order in
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

struct OrderRow: View {
    var order: Order
    var selectorIndex = 0
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Order No: \(order.id)")
                Spacer()
                Text(order.orderDate)
                    .foregroundColor(.gray)
            }.padding([.top], 2)
            HStack {
//                Text("Quantity:")
//                Text("\(order.quantity)")
//                    .foregroundColor(.gray)
//                Spacer()
                Text("Total Amount:")
                Text("\(Int(order.totalPrice))")
                    .foregroundColor(.gray)
            }.padding([.top], 2)
            
            if self.selectorIndex == 0 {
                Text(order.status)
                    .foregroundColor(.green)
                    .padding(.vertical, 1)
            } else if self.selectorIndex == 1 {
                Text(order.status)
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 1)
            } else {
                Text(order.status)
                    .foregroundColor(.red)
                    .padding(.vertical, 1)
            }
           Divider()
        }.font(.footnote)
    }
}
extension MyOrdersView {
    func NavigationBarView() -> some View {
        return HStack {
            Button(action: {
                path.removeLast()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 18, height: 18)
                    .padding(.leading, 25)
            }
            Text("Đơn mua")
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
