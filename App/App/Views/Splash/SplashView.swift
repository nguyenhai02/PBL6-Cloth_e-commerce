//
//  SplashView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel = SplashViewModel()
    
    var body: some View {
        VStack {
            Image("logo4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isLoggIned){
            TagBarView()
        }
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
