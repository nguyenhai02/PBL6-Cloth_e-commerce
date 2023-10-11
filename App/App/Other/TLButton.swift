//
//  TLButton.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(background)
                    .frame(height: 50)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(title: "Login", background: Color.black) {
            // action
        }
    }
}

