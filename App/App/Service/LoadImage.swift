//
//  LoadImage.swift
//  App
//
//  Created by Thanh Hien on 27/10/2023.
//

import Foundation
import SwiftUI

class LoadImage: ObservableObject {
    @Published var image: UIImage?
    @Published var urlImage: String?

    func loadImage(from urlString: String, completed: @escaping () -> Void) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    print("urlString")
                    print(urlString)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                            completed()
                        }
                    } else {
                        print("k thể tạo ảnh")
                    }
                } else {
                    print("k the tạo")
                }
            }
        }
    }
}


