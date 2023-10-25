//
//  ItemRow.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct ItemRow: View {
    @ObservedObject var viewModel = HomeViewModel()
    @Binding var path: NavigationPath
    @State var show = false
    var product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
                    Image(uiImage: viewModel.image ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 190)
                        .cornerRadius(8)
                        .overlay (
                            Button(action: {
                                print("action")
                            }) {
                                Image(systemName: "heart")
                                //                        Image(systemName: product.isFavorite == true ? "heart.fill" : "heart")
                                //                            .foregroundColor(product.isFavorite == true ? .red : .gray)
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                                    .background(Color.white)
                            }
                                .cornerRadius(20)
                                .opacity(0.9)
                                .shadow(color: .gray, radius: 0.5, x: 0.3, y: 0.3)
                                .padding([.top, .trailing], 8)
                            , alignment: .topTrailing)
                        .onAppear {
                                viewModel.loadImage(from: product.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg") {
                                    // Hành động hoàn thành
                                    print("Hình ảnh đã được tải thành công")
                                }
                        }
           
                // label
                Group {
                    Text(product.name)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("272727"))
                        .padding(.top, 9)
                        .padding([.horizontal], 10)
                    //                Text(product.brand)
                    //                    .font(.system(size: 12))
                    //                    .foregroundColor(.gray)
                    //                    .padding(.leading, 5)
                    HStack {
                        Text("đ\((product.price) - ((product.price) * (product.discount) / 100))")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                        //                    Text("đ\(product.price)")
                        //                        .font(.system(size: 10))
                        //                        .strikethrough()
                        Text("\(product.discount)% OFF")
                            .font(.system(size: 11))
                            .foregroundColor(Color("002482"))
                    }
                    .padding([.leading], 10)
                    .padding(.top, 5)
                    HStack {
                        Text("Đã bán")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Text("680")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                    .padding([.horizontal], 10)
                    Text("\(product.category.id)")
                }
                .padding([.horizontal], 5)
            }
                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 280)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1).shadow(radius: 2)).clipped()
                .onTapGesture {
                    self.show = true
                }.navigationDestination(isPresented: $show) {
                    ItemDetailView(path: $path, product: product)
                }
            
    }
}
        

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        ItemRow(path: .constant(NavigationPath()), product: product)
    }
}
