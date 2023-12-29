//
//  ItemDetailView.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI
import Kingfisher

struct ItemDetailView: View, Hashable {
    static func == (lhs: ItemDetailView, rhs: ItemDetailView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
    }
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var loadImageViewModel = LoadImage()
    @ObservedObject var cartModel = CartViewModel()
    @ObservedObject var favouriteViewModel = FavouriteViewModel.instance
    var addressViewModel = AddressViewModel.instance
    var paymentViewModel = PaymentViewModel.instance
    @Binding var path: NavigationPath
    @State var index = 0
    @State var show = false
    @State var isNext = false
    @State var showAddCart = false
    @State private var isDescriptionVisible = false
    let arrImage = ["product2", "product2", "product2", "product2"]
    let productId: Int
    
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 8)
                HStack() {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color("272727"))
                    }
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Button(action: {
                        favouriteViewModel.id = viewModel.productDetail?.product.id ?? 0
                        if favouriteViewModel.favouriteItems.first(where: {$0.product.id == viewModel.productDetail?.product.id}) == nil {
                            favouriteViewModel.addFavouriteProduct()
                        } else {
                            if let id = favouriteViewModel.favouriteItems.first(where: {$0.product.id == viewModel.productDetail?.product.id})?.id {
                                favouriteViewModel.idFavourite = id
                                favouriteViewModel.deleteFavouirteItem()
                            }
                        }
                    }) {
                        favouriteViewModel.favouriteItems.first(where: {$0.product.id == viewModel.productDetail?.product.id}) != nil ?
                        Image(systemName: "heart.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                        : Image(systemName:"heart")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, 30)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        PagingView(index: $index.animation(), maxIndex: arrImage.count - 1 ) {
                            ForEach(0..<4, id: \.self) { _ in
                                KFImage(URL(string: viewModel.productDetail?.product.image  ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                                    .resizable()
                                    .scaledToFill()
//                                    .onAppear{
//                                        viewModel.id = viewModel.productDetail?.product.id ?? 0
//                                        viewModel.getProductDetail()
//                                    }
                            }
                        }.frame(height: 450)
                            .aspectRatio(4/3, contentMode: .fill)
                            .padding(.top, 3)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text(viewModel.productDetail?.product.name ?? "")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("002482"))
                            }
                            .padding([.horizontal], 15)
                            .padding(.top, 12)
                            HStack {
                                Text("đ\((viewModel.productDetail?.product.price ?? 0) - ((viewModel.productDetail?.product.price ?? 0) * (viewModel.productDetail?.product.discount ?? 0) / 100))")
                                
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                Text("VND: \(viewModel.productDetail?.product.price ?? 0)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray) .strikethrough()
                                Text("\(viewModel.productDetail?.product.discount ?? 0)% OFF")
                                    .font(.system(size: 15))
                                    .foregroundColor(.red)
                                    .padding([.top, .bottom], 15)
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                        }
                        .background(Color.white)
                        .padding(.bottom, 10)
                        SelectColorView(viewModel: viewModel, cartModel: cartModel)
                            .padding(.bottom, 10)
                        SelectSizeView(viewModel: viewModel, cartModel: cartModel) {
                            self.isNext = true
                        }
                        .padding(.bottom, 10)
                        VStack(alignment: .leading, spacing: 0) {
                            Color.white
                            Text("Product Details")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            Text(viewModel.productDetail?.product.description ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .padding(.vertical, 8)
                                .lineSpacing(2)
                                .lineLimit(nil)
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .background(Color.white)
                    }
                    //                    }
                }
                Spacer()
                HStack(spacing: 20) {
                    Button(action:  {
                        if isNext {
                            self.showAddCart = true
                        }
                    }) {
                        HStack(spacing: 0) {
                            Text("Thêm vào giỏ")
                                .font(.system(size: 12))
                                .foregroundColor(isNext ? .black : .black.opacity(0.4))
                            Image(systemName: "cart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                        }
                    }
                    .frame(width: 150, height: 42)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(Color("002482"), lineWidth: 1))
                    .sheet(isPresented: $showAddCart) {
                        ProductSelectionView(viewModel: cartModel, homeViewModel: viewModel, title: "Thêm vào giỏ hàng") {
                            self.showAddCart = false
                            cartModel.addCart() {}
                        }
                        .presentationDetents([.fraction(0.6)])
                    }
                    Button("Mua ngay", action:  {
                        if isNext {
                            self.show = true
                        }
                    })
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 42)
                    .sheet(isPresented: $show) {
                        ProductSelectionView(viewModel: cartModel, homeViewModel: viewModel, title: "Mua ngay") {
                            //                            path.append(ItemDetailView(path: $path, productId: cartItem.productId))
                            path.append(PaymentView(path: $path, homeViewModel: viewModel, cartViewModel: cartModel, addressViewModel: addressViewModel, viewModel: paymentViewModel, productDetailPayment: viewModel.productDetail))
                            self.show = false
                        }
                        .presentationDetents([.fraction(0.6)])
                    }
                    .background(isNext ? Color("002482") :  Color("002482").opacity(0.7))
                    .cornerRadius(8)
                }
                .background(.white)
            }
        }
        .navigationDestination(for: PaymentView.self) { product in
            PaymentView(path: $path, homeViewModel: viewModel, cartViewModel: cartModel, addressViewModel: addressViewModel, viewModel: paymentViewModel)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.id = productId
            viewModel.getProductDetail()
        }
    }
}
struct SelectColorView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var cartModel: CartViewModel
    @State var selectedColor: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Color:")
                    .font(.system(size: 20))
                    .foregroundColor(Color("272727"))
                    .fontWeight(.medium)
                Text(cartModel.color)
                    .font(.system(size: 16))
                    .foregroundColor(Color("272727"))
                    .padding(.leading, 6)
            }
            .padding(.top, 16)
            .padding(.horizontal, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    let variants = Array(Set(viewModel.productDetail?.productVariants.map { $0.color } ?? [])).sorted()
                    ForEach(variants, id: \.self) { color in
                        let convertedColor = ConvertStringToColor().convertStringToColor(color: color)
                        Button(action: {
                            if selectedColor == color {
                                selectedColor = ""
                            } else {
                                selectedColor = color
                                cartModel.color = color
                                print("color: \(cartModel.color)")
                                cartModel.productId = viewModel.productDetail?.product.id ?? 0
                                print("cartModel.productId: \(cartModel.productId )")
                            }
                        }) {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundColor(convertedColor)
                        }
                        .shadow(radius: 2)
                        .background(selectedColor == color ? Color("4A3AFF") : .white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color("4A3AFF"), lineWidth: selectedColor == color ? 5 : 0)
                        )
                        .cornerRadius(50)
                        .padding(.leading, 25)
                        .padding(.bottom, 10)
                    }
                }
            }
        }
        .background(Color.white)
    }
}


struct SelectSizeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var cartModel: CartViewModel
    @State var selectedSizes: String = ""
    var addCart: () -> Void
    var body: some View {
        VStack(alignment: .leading)  {
            headerView
            scrollView
        }
        .background(Color.white)
    }
    var headerView: some View {
        HStack {
            Text("Size:")
                .font(.system(size: 20))
                .foregroundColor(Color("272727"))
                .fontWeight(.medium)
            Text(cartModel.size)
                .font(.system(size: 16))
                .foregroundColor(Color("272727"))
                .padding(.leading, 6)
        }
        .padding(.top, 8)
        .padding(.horizontal, 15)
    }
    var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if let variants = viewModel.productDetail?.productVariants {
                    if let variantsForSelectedColor = viewModel.productDetail?.productVariants.filter({ $0.color == cartModel.color }) {
                        let sortedVariants = Array(Set(variants.map { $0.size })).sorted {
                            let sizeOrder: [String: Int] = ["XS": 0, "S": 1, "M": 2, "L": 3, "XL": 4, "XXL": 5]
                            let order1 = sizeOrder[$0] ?? Int.max
                            let order2 = sizeOrder[$1] ?? Int.max
                            return order1 < order2
                        }
                        ForEach(sortedVariants, id: \.self) { size in
                            let isSelectable = variantsForSelectedColor.contains { variant in
                                variant.size == size
                            }
                            if isSelectable {
                                Button(action: {
                                    selectedSizes = size
                                    cartModel.size = selectedSizes
                                    print("selectedSizes: \( cartModel.size)")
                                    addCart()
                                }) {
                                    Text(size)
                                        .foregroundColor(selectedSizes == size ? Color("4A3AFF") : Color("272727"))
                                        .font(.system(size: 17))
                                        .frame(width: 40, height: 30)
                                }
                                .padding(3)
                                .background(Color("CFCFCF").opacity(0.4))
                                .overlay(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color("4A3AFF"), lineWidth: selectedSizes == size ? 1.5 : 0))
                            } else {
                                VStack {
                                    Text(size)
                                        .foregroundColor(.black.opacity(0.4))
                                        .font(.system(size: 17))
                                        .frame(width: 40, height: 30)
                                }
                                .padding(3)
                                .background(Color("CFCFCF").opacity(0.2))
                                .overlay(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color("CFCFCF"), lineWidth: 0))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
        }
    }
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", discount: 10, price: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        ItemDetailView(path: .constant(NavigationPath()), productId: 2)
    }
}
