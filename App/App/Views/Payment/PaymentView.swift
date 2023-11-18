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
    func hash(into hasher: inout Hasher) {
    }
    
    @Binding var path: NavigationPath
//    @Environment(\.openURL) private var openURL
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var cartViewModel: CartViewModel
    @ObservedObject var addressViewModel: AddressViewModel
    @State var showAlert: Bool = false
    let viewModel: PaymentViewModel = PaymentViewModel()
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
                //                Divider().background(.black).shadow(radius: 10)
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
                    //                    Spacer()
                }
                .padding(.leading, 15)
                .padding(.vertical, 5)
                .background(Color("E1E2E7").opacity(0.5))
                //                Divider().background(Color("E1E2E7")).shadow(radius: 1)
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
                    path.append("ChoosePaymentView")
                }) {
                    HStack {
                        Text("Phương phức thanh toán")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        Spacer()
                        Text("Thanh toán khi nhận hàng")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
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
                    viewModel.createPayment()
                    self.showAlert = true
                    print("viewModel.payment?.redirect_url")
                    print(viewModel.payment?.redirect_url ?? "rong")
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Order confirmation"), message: Text(""), dismissButton: .default(Text("OK")) {
                if let url = URL(string: viewModel.payment?.redirect_url ?? "") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    print("url")
                }
                path.append("MyOrdersView")
            })
        }
    }
}


struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        PaymentView(path: .constant(NavigationPath()), homeViewModel: HomeViewModel(), cartViewModel: CartViewModel(), addressViewModel: AddressViewModel())
    }
}
