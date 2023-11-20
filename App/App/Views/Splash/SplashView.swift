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
                LottieView(lottieFile: "splashAnimation")
                    .frame(width: 200, height: 200)
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self){ name in
                getScreen(id: name, path: $path )
            }
        }.onAppear {
            viewModel.checkLogin { isLogined in
                if(isLogined){
                    path.append("TagBarView")
                } else {
                    path.append("LoginView")
                }
            }
        }
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(path: NavigationPath())
    }
}


