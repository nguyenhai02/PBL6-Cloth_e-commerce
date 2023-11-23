//
//  ProductListPaymentView.swift
//  App
//
//  Created by Thanh Hien on 23/11/2023.
//

import SwiftUI
import Kingfisher

struct ProductListPaymentView: View, Hashable {
    static func == (lhs: ProductListPaymentView, rhs: ProductListPaymentView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @Binding var path: NavigationPath
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject var addressViewModel: AddressViewModel
    @ObservedObject var viewModel: PaymentViewModel
    @State var showAlert: Bool = false
    @State var showAlertPayment: Bool = false
    var body: some View {
        VStack(spacing: 0) {
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
                    path.append(ChooseAddressView(viewModel: addressViewModel, path: $path))
                }) {
                    HStack {
                        if(addressViewModel.selectedAddress != nil) {
                            VStack {
                                Image("address2")
                                    .resizable()
                                    .frame(width: 14, height: 20)
                                Spacer()
                            }
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Địa chỉ nhận hàng")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15))
                                HStack(spacing: 0) {
                                    Text(addressViewModel.selectedAddress?.name ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                        .lineLimit(1)
                                    Rectangle()
                                        .frame(width: 1, height: 14)
                                        .foregroundColor(.black)
                                        .padding(.leading, 8)
                                    Text(addressViewModel.selectedAddress?.phone ?? "" )
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .padding(.leading, 6)
                                        .lineLimit(1)
                                }
                                .padding(.top, 5)
                                Text(addressViewModel.selectedAddress?.street ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                Text("\(addressViewModel.selectedAddress?.ward ?? ""), \(addressViewModel.selectedAddress?.district ?? ", \(addressViewModel.selectedAddress?.city ?? "")")")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 10)
                            Spacer()
                            Image("rightlight")
                                .padding(.trailing, 10)
                        } else {
                            VStack(alignment: .leading) {
                                Button(action: {
                                    path.append(ChooseAddressView(viewModel: addressViewModel, path: $path))
                                }) {
                                    HStack {
                                        Image("address2")
                                            .resizable()
                                            .frame(width: 14, height: 20)
                                        Text("Chọn địa chỉ nhận hàng")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15))
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image("rightlight")
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.leading, 12)
                    .navigationDestination(for: ChooseAddressView.self) {_ in
                        ChooseAddressView(viewModel: addressViewModel, path: $path)
                    }
                }
                Spacer().frame(height: 25)
                VStack (spacing: 0) {
                    ForEach(cartViewModel.cartItems, id: \.self) { cartItem in
                        HStack(spacing: 0) {
                                KFImage(URL(string: cartItem.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 85)
                                    .scaledToFill()
                                    .cornerRadius(1)
                                    .padding(.leading, 20)
                            VStack(alignment: .leading, spacing: 0) {
                                HStack   {
                                    Text(cartItem.productName)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("002482"))
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.top, 15)
                                HStack(spacing: 0) {
                                    Text("Màu: ")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    Text(cartItem.color)
                                        .font(.system(size: 13))
                                        .foregroundColor(.black.opacity(0.7))
                                    Text("Size: ")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                        .padding(.leading, 22)
                                    Text(cartItem.size)
                                        .font(.system(size: 13))
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                .padding(.top, 5)
                                HStack(spacing: 0) {
                                    Text("Số lượng: ")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    Text("\(Int(cartItem.quantity))")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black.opacity(0.7))
                                    Text("Giá: ")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                        .padding(.leading, 15)
                                    Text("\(Int(cartItem.price))")
                                        .font(.system(size: 13))
                                        .foregroundColor(Color("002482"))
                                }
                                .padding(.top, 5)
                            }
                            .padding(.leading, 20)
                            .padding(.bottom, 15)
                        }
                        
                        //                    .cornerRadius(6)
                        //                    .padding([.leading, .trailing], 20)
                        //                    Spacer().frame(height: 25)
                    }
                    .padding(.top, 10)
                }
                .background(Color("E1E2E7").opacity(0.2))
                    Spacer().frame(height: 25)
                    HStack {
                        Text("Tổng số tiền:")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        Text("\(cartViewModel.cartItems.reduce(0, { $0 + Int($1.price) * $1.quantity })) VND")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .padding(.trailing, 15)
                    }
                    .padding(.leading, 12)
                    Spacer().frame(height: 20)
                    Divider().background(Color("E1E2E7"))
                Button(action: {
                    path.append(ChoosePaymentView(viewModel: viewModel, path: $path))
                }) {
                    HStack {
                        Text("Phương phức thanh toán")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        Spacer()
                        Text(viewModel.paymentMethod?.description ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        Image(systemName: "greaterthan")
                            .resizable()
                            .foregroundColor(.black.opacity(0.8))
                            .frame(width: 8, height: 15)
                            .padding(.trailing, 12)
                            .padding(.leading, 5)
                    }
                }
                .padding(.leading, 12)
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
                        Text("\(cartViewModel.cartItems.reduce(0, { $0 + Int($1.price) * $1.quantity })) VND")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .fontWeight(.medium)
                            .padding(.top, 8)
                    }
                }
                .frame(height: 52)
                .padding(.leading, 100)
                Spacer()
                Button(action: {
                    if viewModel.paymentMethod  == Payment.money {
                        self.showAlert = true
                    } else if  viewModel.paymentMethod  == Payment.vnpay{
                        viewModel.amount = cartViewModel.total
                        viewModel.createPayment()
                        self.showAlert = true
                    } else {
                        showAlertPayment = true
                    }
                }) {
                    Text("Đặt Hàng")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 52)
                .background(Color("002482").opacity(0.9))
                .alert("Vui Lòng chọn phương thức thanh toán", isPresented: $showAlertPayment){}
            }
            Divider().background(Color("E1E2E7"))
            Spacer().frame(height: 8)
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Xác nhận đặt hàng"), message: Text(""), primaryButton: .default( Text("Có")){
                if  viewModel.paymentMethod  == Payment.vnpay {
                    if let url = URL(string: viewModel.payment?.redirect_url ?? "") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else if viewModel.paymentMethod  == Payment.money  {
                    cartViewModel.CreateCOD(amount: cartViewModel.total) {
                       path.append("MyOrdersView")
                   }
                }
                
            }, secondaryButton: .cancel(Text("Huỷ")) {
                showAlert = false
            })
        }
        .navigationDestination(for: ChoosePaymentView.self) {_ in
            ChoosePaymentView(viewModel: viewModel, path: $path)
        }
        .onAppear {
            cartViewModel.getCartItems()
        }
    }
}


struct ProductListPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListPaymentView(path: .constant(NavigationPath()), cartViewModel: CartViewModel(), addressViewModel: AddressViewModel(), viewModel: PaymentViewModel())
    }
}
