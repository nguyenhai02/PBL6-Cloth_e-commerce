//
//  SplashView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel = SplashViewModel()
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                Image("logo4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $viewModel.isLoggIned){
                    TagBarView(path: $path)
                }
            .navigationDestination(isPresented: $viewModel.isNonLoggIned){
                    LoginView(path: $path)
                }
        }
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(path: NavigationPath())
    }
}
