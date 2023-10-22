//
//  RadioButtonGroup.swift
//  App
//
//  Created by Vo Duc Phong on 22/10/2023.
//

import SwiftUI

struct ItemAddress{
    let name: String
    let phone: String
    let address: String
    let contries: String
}

struct RadioButtonRow: View {
    var index: Int
    var item: ItemAddress
    @Binding var isSelected: Bool
    var action: (_ index:Int) -> Void
    
    var body: some View {
        
        return HStack {
            ZStack{
                if isSelected {
                    Circle().inset(by: 6)
                }
            }.frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(Color.red)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red, lineWidth: 2)
                )
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    
                    Text(item.name)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                    Rectangle()
                        .frame(width: 1, height: 15)
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                    Text(item.phone)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                Text(item.address)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                Text(item.contries)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                Divider()
                    .padding(.horizontal, 30)
                
            }
            .padding(.leading, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            action(index)
        }
    }
}

struct RadioAddressGroup: View {
    
    var items: [ItemAddress]
    @State var selection:Int
    var onAddAddress: () -> Void
    
    var body: some View {
        VStack {
            ForEach(0..<items.count, id:\.self) {
                index in
                
                RadioButtonRow(index: index, item: self.items[index], isSelected: .constant(self.selection==index), action: { i in
                    print(i)
                    self.selection = i
                })
            }
            
            Spacer().frame(height: 40)
            
            Button(action: {
                onAddAddress()
            }, label: {
                Text("Thêm địa chỉ")
            })
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
    }
}

struct RadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioAddressGroup(items: [ItemAddress(name: "Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), ItemAddress(name: "Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), ItemAddress(name: "Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam")], selection: 0, onAddAddress: {
            
        })
    }
}
