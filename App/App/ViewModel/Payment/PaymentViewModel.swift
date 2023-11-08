//
//  PaymentViewModel.swift
//  App
//
//  Created by Thanh Hien on 26/10/2023.
//

import Foundation

struct PaymentViewModel: ViewModel{
    let item: ItemAddress = ItemAddress(name: "Nguyen thi Thanh Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam")
    let product: Product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
    
}
