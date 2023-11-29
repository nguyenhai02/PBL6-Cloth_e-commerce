import Foundation
import CardPayments

struct CardPaymentState: Equatable {
    static func == (lhs: CardPaymentState, rhs: CardPaymentState) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
    }
    

    struct CardResult: Decodable, Equatable {

        let id: String
        let deepLinkURL: String?
    }

    var createOrder: Order1?
    var authorizedOrder: Order1?
    var capturedOrder: Order1?
    var intent: Intent = .authorize
    var scaSelection: SCA = .scaWhenRequired
    var approveResult: CardResult?

    var createdOrderResponse: LoadingState<Order1> = .idle {
        didSet {
            if case .loaded(let value) = createdOrderResponse {
                createOrder = value
            }
        }
    }

    var approveResultResponse: LoadingState<CardResult> = .idle {
        didSet {
            if case .loaded(let value) = approveResultResponse {
                approveResult = value
            }
        }
    }

    var capturedOrderResponse: LoadingState<Order1> = .idle {
        didSet {
            if case .loaded(let value) = capturedOrderResponse {
                capturedOrder = value
            }
        }
    }

    var authorizedOrderResponse: LoadingState<Order1> = .idle {
        didSet {
            if case .loaded(let value) = authorizedOrderResponse {
                authorizedOrder = value
            }
        }
    }
}
