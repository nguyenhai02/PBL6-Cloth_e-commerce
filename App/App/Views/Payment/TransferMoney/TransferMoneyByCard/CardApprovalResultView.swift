import SwiftUI

struct CardApprovalResultView: View {

    @ObservedObject var cardPaymentViewModel: PaymentViewModel

    var body: some View {
        switch cardPaymentViewModel.state.approveResultResponse {
        case .idle, .loading:
            EmptyView()
        case .loaded(let approvalResult):
            getSuccessView(approvalResult: approvalResult)
        case .error(let errorMessage):
            Text(errorMessage).foregroundColor(.red)
        }
    }

    func getSuccessView(approvalResult: CardPaymentState.CardResult) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Thanh toán thành công")
                    .font(.system(size: 20))
                Spacer()
            }
            Text("ID").fontWeight(.bold)
            Text("\(approvalResult.id)")
            Text("3DS URL").fontWeight(.bold)
            Text("\(approvalResult.deepLinkURL ?? "NOT SET")")
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
