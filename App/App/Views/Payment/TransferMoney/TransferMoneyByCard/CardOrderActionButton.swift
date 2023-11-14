import SwiftUI

struct CardOrderActionButton: View {

    let intent: Intent
    let orderID: String
    let selectedMerchantIntegration: MerchantIntegration

    @ObservedObject var cardPaymentViewModel: PaymentViewModel

    var body: some View {
        ZStack {
            Button("\(intent.rawValue)") {
                completeOrder()
            }
            .padding()

            if .loading == cardPaymentViewModel.state.authorizedOrderResponse ||
                .loading == cardPaymentViewModel.state.capturedOrderResponse {
                ProgressView()
            }
        }
    }

    private func completeOrder() {
        if intent == .capture {
            Task {
                do {
                    try await cardPaymentViewModel.captureOrder(
                        orderID: orderID,
                        selectedMerchantIntegration: selectedMerchantIntegration
                    )
                    print("Order Captured. ID: \(cardPaymentViewModel.state.capturedOrder?.id ?? "")")
                } catch {
                    print("Error capturing order: \(error.localizedDescription)")
                }
            }
        } else {
            Task {
                do {
                    try await cardPaymentViewModel.authorizeOrder(
                        orderID: orderID,
                        selectedMerchantIntegration: selectedMerchantIntegration
                    )
                    print("Order Authorized. ID: \(cardPaymentViewModel.state.authorizedOrder?.id ?? "")")
                } catch {
                    print("Error authorizing order: \(error.localizedDescription)")
                }
            }
        }
    }
}
