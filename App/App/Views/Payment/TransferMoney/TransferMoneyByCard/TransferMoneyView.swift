//
//  TransferMoney.swift
//  App
//
//  Created by Thanh Hien on 13/11/2023.
//

import SwiftUI
import Kingfisher

struct TransferMoneyView: View{
    
    @Binding var path: NavigationPath
   
    @StateObject var cardPaymentViewModel = PaymentViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Quy trình thanh toán")
                
                CreateOrderCardPaymentView(
                    cardPaymentViewModel: cardPaymentViewModel,
                    selectedMerchantIntegration: MerchantIntegration.direct
                )
                
                if let order = cardPaymentViewModel.state.createOrder {
                    OrderCreateCardPaymentResultView(cardPaymentViewModel: cardPaymentViewModel)
                    Button(action: {
                        path.append(CardOrderApproveView(orderID: order.id, cardPaymentViewModel: cardPaymentViewModel))
                    }){
                        Text("Thanh toán bằng thẻ của bạn")
                    }
                    .padding()
                    .navigationDestination(for: CardOrderApproveView.self) { _ in
                        CardOrderApproveView(orderID: order.id, cardPaymentViewModel: cardPaymentViewModel)
                    }
                }
            }
        }
    }
}


struct TranferMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        TransferMoneyView(path: .constant(NavigationPath()))
    }
}

