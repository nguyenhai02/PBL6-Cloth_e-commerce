import SwiftUI

struct CardOrderCompletionResultView: View {

    @ObservedObject var cardPaymentViewModel: PaymentViewModel

    var body: some View {
        switch cardPaymentViewModel.state.authorizedOrderResponse {
        case .idle, .loading:
            EmptyView()
        case .loaded(let authorizedOrderResponse):
            getOrderSuccessView(orderResponse: authorizedOrderResponse, intent: "Authorized")
        case .error(let errorMessage):
            Text(errorMessage).foregroundColor(.red)
        }

        switch cardPaymentViewModel.state.capturedOrderResponse {
        case .idle, .loading:
            EmptyView()
        case .loaded(let capturedOrderResponse):
            getOrderSuccessView(orderResponse: capturedOrderResponse, intent: "Captured")
        case .error(let errorMessage):
            Text(errorMessage).foregroundColor(.red)
        }
    }

    func getOrderSuccessView(orderResponse: Order1, intent: String) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Order \(intent)")
                    .font(.system(size: 20))
                Spacer()
            }
            Text("Order ID").fontWeight(.bold)
            Text("\(orderResponse.id)")
            Text("Status").fontWeight(.bold)
            Text("\(orderResponse.status)")
            if let lastDigits = orderResponse.paymentSource?.card.lastDigits {
                Text("Card Last Digits").fontWeight(.bold)
                Text("\(lastDigits)")
            }
            if let brand = orderResponse.paymentSource?.card.brand {
                Text("Brand").fontWeight(.bold)
                Text("\(brand)")
            }
            if let vaultID = orderResponse.paymentSource?.card.attributes?.vault.id {
                Text("Vault ID / Payment Token").fontWeight(.bold)
                Text("\(vaultID)")
            }
            if let customerID = orderResponse.paymentSource?.card.attributes?.vault.customer.id {
                Text("Customer ID").fontWeight(.bold)
                Text("\(customerID)")
            }
            Text("")
                .id("bottomView")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 2)
                .padding(5)
        )
    }
}
