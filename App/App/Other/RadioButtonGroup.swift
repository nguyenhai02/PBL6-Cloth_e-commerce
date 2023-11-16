//
//  RadioButtonGroup.swift
//  App
//
//  Created by Vo Duc Phong on 22/10/2023.
//

import SwiftUI

struct RadioButtonRow: View {
    var index: Int
    var item: Address
    @State var isSelected: Bool
    var action: (_ index:Int) -> Void
    var editAction: (_ index:Int) -> Void
    
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
                        editAction(index)
                    }) {
                        Text("sửa")
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                            .padding(.trailing, 1)
                    }
                }
                .padding(.top, 20)
                Text(item.street)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                Text("\(item.district) \(item.ward) \(item.city)")
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
    @Binding var path: NavigationPath
    @State var selection: Int
    @ObservedObject var viewModel: AddressViewModel
    @State var indexEditSelected = 0
    var action: () -> Void
    
    var body: some View {
        VStack {
            ForEach(0..<viewModel.savedAddessed.count, id:\.self) {
                index in
                RadioButtonRow(
                    index: index,
                    item: viewModel.savedAddessed[index],
                    isSelected: false,
                    action: { i in
                        self.selection = i
                        print(viewModel.savedAddessed[selection])
                        viewModel.selectedAddress = viewModel.savedAddessed[selection]
                        action()
                    }, editAction: { index in
                        self.indexEditSelected = index
                        path.append(UpdateAddressView(viewModel: viewModel, path: $path, itemAddess:  viewModel.savedAddessed[index]))
                    })
                .navigationDestination(for: UpdateAddressView.self) {_ in
                    VStack{
                        UpdateAddressView(viewModel: viewModel, path: $path, itemAddess:  viewModel.savedAddessed[indexEditSelected], indexEdit: indexEditSelected)
                    }
                }
            }
            Spacer().frame(height: 30)
            Button(action: {
                path.append("AddAddressView")
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
        RadioAddressGroup(path: .constant(NavigationPath()), selection: 0, viewModel: AddressViewModel(), action: {})
    }
}
//
//RadioAddressGroup(path: .constant(NavigationPath()), items: [Address(name: "Hien", phone: "0572435622", street: "Khanh toan", city: "Da Nang", ward: "hai chau", district: "Hoa cuong")], selection: 0, onAddAddress: {
//
//}, viewModel: AddressViewModel())
