//
//  SplashView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct SplashView: View {
//    static func == (lhs: SplashView, rhs: SplashView) -> Bool {
//        return true
//    }
//    func hash(into hasher: inout Hasher) {
//
//    }
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


