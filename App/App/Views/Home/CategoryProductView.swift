//
//  CategoryProductView.swift
//  App
//
//  Created by Thanh Hien on 23/10/2023.
//

import SwiftUI

struct CategoryProductView: View, Hashable{
    static func == (lhs: CategoryProductView, rhs: CategoryProductView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
        
    }
    @ObservedObject var viewModel: HomeViewModel
    @Binding var path: NavigationPath
    let columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 10, maximum: 170)), count: 2)
    var category: Categories
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
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
                Text("Tops")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 50)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.categoryProduct, id: \.product.id) {
                        productDetail in
                        ItemRow(path: $path, product: productDetail)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print( viewModel.categoryId)
            viewModel.showCategoryProduct(categoryId: viewModel.categoryId)
        }
    }
}
struct CategoryProductView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryProductView(viewModel: HomeViewModel(), path: .constant(NavigationPath()), category: Categories(id: 4, name: "Thanh Hien", description: " Thanh Hien", createDate: "1/1/2002", updateDate: "1/2/2002"))
    }
}
