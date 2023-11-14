import SwiftUI

struct OrderCreateCardPaymentResultView: View {

    @ObservedObject var cardPaymentViewModel: PaymentViewModel

    var body: some View {
        switch cardPaymentViewModel.state.createdOrderResponse {
        case .idle, .loading:
            EmptyView()
        case .loaded(let createOrderResponse):
            getSuccessView(createOrderResponse: createOrderResponse)
        case .error(let errorMessage):
            Text(errorMessage).foregroundColor(.red)
        }
    }

    func getSuccessView(createOrderResponse: Order) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Thông tin đơn hàng")
                    .font(.system(size: 20))
                Spacer()
            }
            Text("Order ID").fontWeight(.bold)
            Text("\(createOrderResponse.id)")
            Text("Status").fontWeight(.bold)
            Text("\(createOrderResponse.status)")
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
