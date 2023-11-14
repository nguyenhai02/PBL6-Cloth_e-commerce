//
//  PhotoPickerViewModel.swift
//  App
//
//  Created by Thanh Hien on 28/10/2023.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

class PhotoPickerViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var imageURL: String? = ""
    let profileViewModel = ProfileViewModel()
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection) {
                
            }
        }
    }
    
    func setImage(from selection: PhotosPickerItem?, completed: @escaping () -> Void) {
        guard let selection = selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async { [self] in
                        self.selectedImage = uiImage
                        print("haha")
                        guard let image = self.selectedImage else {
                            print("Selected image is nil.")
                            return
                        }
                        UploadImageToFirebase().upLoadImage(image) { result in
                            // Xử lý kết quả tại đây
                            print("setImage2")
                            switch  result {
                            case .success(let url):
                                self.profileViewModel.avatar = url.absoluteString
                                self.profileViewModel.updateProfile()
                                print("url laf : \( url.absoluteString)")
                                self.profileViewModel.updateProfile()
                            case .failure(_):
                                print("error")
                            }
                              
                            
                        }
                        completed() // Gọi hàm hoàn tất
                    }
                }
            }
        }
    }
}
