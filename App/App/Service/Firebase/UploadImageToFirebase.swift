//
//  UploadImageToFirebase.swift
//  App
//
//  Created by Thanh Hien on 31/10/2023.
//

import Foundation
import FirebaseStorage

class  UploadImageToFirebase  {
    func upLoadImage(_ image: UIImage?, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.3) else {
            let error = NSError(domain: "khong co anh", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child("Avatar/\(filename)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                    print("fail")
                    return
                }
                guard let url = url else {
                    let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
                    completion(.failure(error))
                    return
                }
                print("urlla \(url)")
                completion(.success(url))
            }
        }
    }
}
