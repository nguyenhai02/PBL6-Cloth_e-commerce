//
//  AddressViewModel.swift
//  App
//
//  Created by Thanh Hien on 23/10/2023.
//

import Foundation
import Moya

class AddressViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var street: String = ""
    @Published var city: String = ""
    @Published var ward: String = ""
    @Published var district: String = ""
    @Published var errorMessage: String = ""
    @Published var addresses: [Province] = []
    @Published var savedAddessed: [Address] = [] //[2]
    @Published var selectedAddress: Address? = nil
    static var instance = AddressViewModel()
    init() {
        self.getAddress()
    }
    func saveAddress(_ address: Address, completed: @escaping () -> Void) {
        guard invalid() else {
            return
        }
        var addresses = savedAddessed //[2]
        addresses.append(address) //[3]
        UserDefaults.standard.setEncodablesAsArrayOfDictionaries(addresses, for: Constanst.savedAddess) //[3]
        completed()
    }
    func getAddress() {
        savedAddessed = UserDefaults.standard.getDecodablesFromArrayOfDictionaries(for:  Constanst.savedAddess)  ?? []
    }
    
    func editAddress(indexEdit: Int, address: Address, completed: @escaping () -> Void) {
        name = address.name
        phone = address.phone
        street = address.street
        city = address.city
        district = address.district
        ward = address.ward
        guard invalid() else {
            return
        }
        savedAddessed.remove(at: indexEdit)
        var addresses = savedAddessed //[2]
        addresses.insert(address, at: indexEdit) //[3]
        UserDefaults.standard.setEncodablesAsArrayOfDictionaries(addresses, for: Constanst.savedAddess) //[3]
        completed()
    }
    
    func getAddressFromURL() {
        let provider = MoyaProvider<ProvinceService>()
        provider.request(.getProvinces) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let address = try filteredResponse.map([Province].self)
                    self.addresses = address
                    print(address)
                } catch {print("Error mapping response: \(error)")}
                print("Hien hihi")
            case let .failure(error):
                print(error)
                print("Hien hihi Xoa k thanh cong")
            }
        }
    }
    
    private func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    func invalid() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !phone.trimmingCharacters(in: .whitespaces).isEmpty, !street.isEmpty, !ward.trimmingCharacters(in: .whitespaces).isEmpty, !district.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all fileds"
                return false
        }
        guard isValidPhone(phone: phone) else {
            errorMessage = "Please enter a valid 10-digit phone number"
            return false
        }
            return true
    }
}
