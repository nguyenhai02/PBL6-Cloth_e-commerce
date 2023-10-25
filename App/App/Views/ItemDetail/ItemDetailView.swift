//
//  ItemDetailView.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    @ObservedObject var viewModel = HomeViewModel()
    @State var index = 0
    @State var show = false
    @State var showPayment = false
    @State private var isDescriptionVisible = false
    let product: Product
    let arrImage = ["product2", "product2", "product2", "product2"]
    let arrSize = ["S", "M", "L", "XL"]
    
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 8)
                HStack() {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
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
                        // action
                    }) {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("272727"))
                    }
                    .padding(.trailing, 30)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        PagingView(index: $index.animation(), maxIndex: arrImage.count - 1 ) {
                            ForEach(0..<4, id: \.self) { _ in
                                Image(uiImage: viewModel.image ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .onAppear{
                                        viewModel.loadImage(from: product.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg") {
                                            print("Thanh cong")
                                        }
                                }
                            }
                        }.frame(height: 450)
                            .aspectRatio(4/3, contentMode: .fill)
                            .padding(.top, 3)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text(product.name)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("002482"))
                            }
                            .padding([.horizontal], 15)
                            .padding(.top, 12)
                            HStack {
                                Text("đ\((product.price) - ((product.price) * (product.discount) / 100))")
                                
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                Text("VND: \(product.price)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray) .strikethrough()
                                Text("\(product.discount)% OFF")
                                    .font(.system(size: 15))
                                    .foregroundColor(.red)
                                    .padding([.top, .bottom], 15)
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                        }
                        .background(Color.white)
                        .padding(.bottom, 10)
                        SelectColorView()
                            .padding(.bottom, 10)
                        SelectSizeView()
                            .padding(.bottom, 10)
                        VStack(alignment: .leading, spacing: 0) {
                            Color.white
                            Text("Product Details")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            Text(product.description)
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
                }
                HStack(spacing: 20) {
                    Button(action:  {
                        
                    }) {
                        HStack(spacing: 0) {
                            Text("Thêm vào giỏ")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            Image(systemName: "cart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                        }
                    }
                    .frame(width: 150, height: 38)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(Color("002482"), lineWidth: 1))
                    Button("Mua ngay", action:  {
                        self.show = true
                    })
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 38)
                    .sheet(isPresented: $show) {
                        ProductSelectionView(path: $path, product: product) {
                            self.showPayment = true
                            self.show = false
                        }
                        .presentationDetents([.fraction(0.6)])
                    }
                    .background(Color("002482"))
                    .cornerRadius(8)
                }
                .background(.white)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showPayment) {
            PaymentView(path: $path, item: ItemAddress(name: "Nguyen thi Thanh Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), product: Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")))
            
        }
    }
}

struct SelectColorView: View {
    @State var color: Color?
    var arrColor = [Color("FFCFB5"), Color("96F9FF"), Color("FEC8FF"), Color("C1C1C1"), Color("FEFFC1")]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color")
                .font(.system(size: 18))
                .foregroundColor(Color("272727"))
                .fontWeight(.medium)
                .padding(.top, 16)
                .padding(.horizontal, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(arrColor, id: \.self) { color in
                        Button(action: {
                            self.color = color
                        }) {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundColor(color)
                        }
                        .background(self.color == color ? Color("4A3AFF") : .white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color("4A3AFF"), lineWidth: self.color == color ? 5 : 0)
                        )
                        .cornerRadius(50)
                        .padding(.leading, 25)
                        .padding(.bottom, 10)
                    }
                }
            }
        }
        .background(.white)
    }
}
struct SelectSizeView: View  {
    @State var size: String?
    let arrSize = ["XS","S", "M", "L", "XL"]
    var body: some View {
        VStack(alignment: .leading)  {
            Text("Size")
                .font(.system(size: 20))
                .foregroundColor(Color("272727"))
                .fontWeight(.medium)
                .padding(.top, 8)
                .padding(.horizontal, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(arrSize, id: \.self) { size in
                        Button(action: {
                            self.size = size
                        }) {
                            Text(size)
                                .foregroundColor( self.size == size ? Color("4A3AFF") : Color("272727"))
                                .font(.system(size: 17))
                                .frame(width: 40, height: 30)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 0)
                            .stroke(Color("4A3AFF"), lineWidth: self.size == size ? 1.5 : 0))
                    }
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }
        }
        .background(.white)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(path: .constant(NavigationPath()), product: Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")))
    }
}
