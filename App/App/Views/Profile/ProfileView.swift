//
//  ProfileView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("product")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 57, height: 57)
                HStack {
                    
                }
            }
            
            Spacer()
        }
//
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
