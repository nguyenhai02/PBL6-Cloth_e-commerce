//
//  RadioButtonGroup.swift
//  App
//
//  Created by Vo Duc Phong on 22/10/2023.
//

import SwiftUI

struct RadioButtonRow: View {
    var index: Int
    var item: ItemAddress
    @Binding var isSelected: Bool
    var action: (_ index:Int) -> Void
    
    var body: some View {
        return HStack {
            ZStack {
                if isSelected {
                    Circle().inset(by: 6)
                }
            }.frame(width: 22, height: 22, alignment: .center)
                .foregroundColor(isSelected ? Color.red: Color.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.red: Color.gray, lineWidth: 2)
                )
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text(item.name)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .lineLimit(1)
                    Rectangle()
                        .frame(width: 1, height: 15)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    Text(item.phone)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.leading, 6)
                        .lineLimit(1)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("sửa")
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                            .padding(.trailing, 1)
                    }
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
            }
            .padding(.leading, 12)
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
//                   print( items[index])
                    self.selection = i
                })
            }
            Spacer().frame(height: 30)
            Button(action: {
                // actionon
                onAddAddress()
            }, label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                    .frame(width: 18, height: 18)
                Text("Thêm địa chỉ")
                    .font(.system(size: 16))
                    .foregroundColor(.red)
            })        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
    }
}

struct RadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioAddressGroup(items: [ItemAddress(name: "Nguyễn Thị Thanh Hiền", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), ItemAddress(name: "Nguỹen Thị Thanh Hiên", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam"), ItemAddress(name: "Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam")], selection: 0, onAddAddress: {
            
        })
    }
}
