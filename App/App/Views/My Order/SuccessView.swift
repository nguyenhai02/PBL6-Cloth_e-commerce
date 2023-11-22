//
//  SuccessView.swift


import SwiftUI

struct SuccessView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .center) {
            Image("success")
                .resizable()
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fit)
            Text("Success!")
                .font(.largeTitle)
                .padding(.vertical, 10)
            Text("Your order will be delivered soon. Thank you for choosing our app.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.bottom, 100)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                path.removeLast()
            }
        }
        
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(path:.constant(NavigationPath()))
    }
}
