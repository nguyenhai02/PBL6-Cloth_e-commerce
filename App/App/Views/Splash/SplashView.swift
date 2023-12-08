//
//  SplashView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var viewModel : SplashViewModel
    @State var path = NavigationPath()
    var onNavigateToSuccessScreen: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack(alignment: .trailing){
                Color.white
                    .edgesIgnoringSafeArea(.all)
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
            }.onReceive(viewModel.$isPaymentSuccess){ _ in
                print("############-> onReceive(viewModel.$isPaymentSuccess)")
                if(viewModel.isPaymentSuccess){
                    path.append("SuccessView")
                }
            }
        }
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}


