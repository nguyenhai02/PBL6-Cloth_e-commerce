//
//  UserDefaultExt.swift
//  App
//
//  Created by Thanh Hien on 11/11/2023.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String : Any]
    }
}

extension Decodable {
    init?(dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        guard let object = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = object
    }
}

extension UserDefaults {
    func setEncodableAsDictionary<T: Encodable>(_ encodable: T, for key: String) {
        self.set(encodable.asDictionary, forKey: key)
    }
    
    func getDecodableFromDictionary<T: Decodable>(for key: String) -> T? {
        guard let dictionary = self.dictionary(forKey: key) else {
            return nil
        }
        return T(dictionary: dictionary)
    }
    
    func setEncodablesAsArrayOfDictionaries<T: Encodable>(_ encodables: Array<T>, for key: String) {
        let arrayOfDictionaries = encodables.map({ $0.asDictionary })
        self.set(arrayOfDictionaries, forKey: key)
    }
    
    func getDecodablesFromArrayOfDictionaries<T: Decodable>(for key: String) -> [T]? {
        guard let arrayOfDictionaries = self.array(forKey: key) as? [[String: Any]] else {
            return nil
        }
        return arrayOfDictionaries.compactMap({ T(dictionary: $0) })
    }
}
