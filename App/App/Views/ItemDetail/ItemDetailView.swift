//
//  ItemDetailView.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var index = 0
    @State private var isDescriptionVisible = false
    let product: Product
    let arrImage = ["product2", "product2", "product2", "product2"]
    let arrSize = ["S", "M", "L", "XL"]
    
    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("272727"))
                        .frame(width: 30, height: 30)
                }
                Button(action: {
                    
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(Color("272727"))
                        .frame(width: 30, height: 30)

                }
                Button(action: {
                    
                }) {
                    Image(systemName: "bag")
                        .foregroundColor(Color("272727"))
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.trailing, 26)
            .frame(maxWidth: .infinity, alignment: .trailing)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    PagingView(index: $index.animation(), maxIndex: arrImage.count - 1 ) {
                        ForEach(arrImage, id: \.self) { image in
                            Image(image)
                                .scaledToFill()
                        }
                    }.frame(height: 500)
                    .aspectRatio(4/3, contentMode: .fill)
                    Group {
                        Text(product.name)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color("272727"))
                            .padding(.top, 9)
                        Text(product.brand)
                            .font(.system(size: 18))
                            .foregroundColor(Color("272727"))
                            .padding(.top, 5)
                        Text("VND: \(product.price)")
                            .font(.system(size: 18))
                            .foregroundColor(Color("272727"))
                            .padding(.top, 7)
                        SelectColorView()
                        SelectSizeView()
                        HStack {
                            Text("Product Details")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(Color("272727"))
                            Image(systemName: self.isDescriptionVisible ? "chevron.down" : "chevron.up")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 30)
                                   }
                                    .padding(.top, 15)
                                   .onTapGesture {
                                       self.isDescriptionVisible.toggle()
                                   }
                                   if isDescriptionVisible {
                                       Text(product.description)
                                           .padding(.top, 7)
                                           .font(.system(size: 14))
                                           .foregroundColor(Color("272727"))
                                   }
                    }
                    .padding([.leading], 15)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
     }
}
struct SelectColorView: View {
    @State var color: Color?
//    var arrColor = [Color.brown, Color.gray, Color.blue, Color.green]
    var arrColor = [Color("FFCFB5"), Color("96F9FF"), Color("FEC8FF"), Color("C1C1C1"), Color("FEFFC1")]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color")
                .font(.system(size: 18))
                .foregroundColor(Color("272727"))
                .fontWeight(.medium)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(arrColor, id: \.self) { color in
                        Button(action: {
                            self.color = color
                        }) {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundColor(color)
                                .padding(3)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 0)
                            .stroke(Color("4A3AFF"), lineWidth: self.color == color ? 1.5 : 0))
                    }
                }
            }
        }
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
        }
    }
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(product:  Product(id: 2, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "Band Name", price: "200000", brand: "Band Name", isFavorite: true))
    }
}
