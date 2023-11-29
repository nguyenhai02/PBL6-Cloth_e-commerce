//
//  PaymentView.swift
//  App
//
//  Created by Thanh Hien on 24/10/2023.
//

import SwiftUI
import Kingfisher

struct PaymentView: View, Hashable{
    static func == (lhs: PaymentView, rhs: PaymentView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @Binding var path: NavigationPath
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var cartViewModel: CartViewModel
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
                HStack {
                    KFImage(URL(string: homeViewModel.productDetail?.product.image ?? ""))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(homeViewModel.productDetail?.product.name ?? "")
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .padding(.top, 15)
                        HStack(spacing: 0) {
                            Text("đ\((homeViewModel.productDetail?.product.price ?? 0) - ((homeViewModel.productDetail?.product.price ?? 0) * (homeViewModel.productDetail?.product.discount ?? 0) / 100))")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("x\(cartViewModel.quantity)")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .padding(.trailing, 15)
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.leading, 10)
                }
                .padding(.leading, 15)
                .padding(.vertical, 5)
                .background(Color("E1E2E7").opacity(0.5))
                Spacer().frame(height: 25)
                HStack {
                    Text("Tổng số tiền:")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(((homeViewModel.productDetail?.product.price ?? 0) - ((homeViewModel.productDetail?.product.price ?? 0) * (homeViewModel.productDetail?.product.discount ?? 0) / 100)) * (cartViewModel.quantity))")
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
                        Text("\(((homeViewModel.productDetail?.product.price ?? 0) - ((homeViewModel.productDetail?.product.price ?? 0) * (homeViewModel.productDetail?.product.discount ?? 0) / 100)) * (cartViewModel.quantity))")
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
                        let amount = Double(((homeViewModel.productDetail?.product.price ?? 0) - ((homeViewModel.productDetail?.product.price ?? 0) * (homeViewModel.productDetail?.product.discount ?? 0) / 100)) * (cartViewModel.quantity))
                        if let street = addressViewModel.selectedAddress?.street,
                           let district = addressViewModel.selectedAddress?.district,
                           let ward = addressViewModel.selectedAddress?.ward,
                           let city = addressViewModel.selectedAddress?.city {
                            let addressDelivery = "\(street), \(district), \(ward), \(city)"
                            viewModel.createPayment(amount: amount, addressDelivery: addressDelivery, productId: cartViewModel.quantity, color: cartViewModel.color, size: cartViewModel.size, quantity: cartViewModel.quantity)
                            self.showAlert = true
                        }
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
                if let url = URL(string: viewModel.payment?.redirect_url ?? "") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }, secondaryButton: .cancel(Text("Huỷ")) {
                showAlert = false
            })
        }
        .navigationDestination(for: ChoosePaymentView.self) {_ in
            ChoosePaymentView(viewModel: viewModel, path: $path)
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(path: .constant(NavigationPath()), homeViewModel: HomeViewModel(), cartViewModel: CartViewModel(), addressViewModel: AddressViewModel(), viewModel: PaymentViewModel())
    }
}
