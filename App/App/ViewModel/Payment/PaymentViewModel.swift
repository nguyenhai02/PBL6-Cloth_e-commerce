//
//  PaymentViewModel.swift
//  App
//
//  Created by Thanh Hien on 26/10/2023.
//

import Foundation
import CardPayments
import CorePayments
import Moya

enum Payment: String, CustomStringConvertible  {
    case money
    case vnpay
    
    var description: String {
        switch self {
        case .money:
            return "Thanh Toán Khi nhận hàng"
        case .vnpay:
            return "Vnpay"
        }
    }
}

class PaymentViewModel: ObservableObject, CardDelegate{
    @Published var payment: PaymentResponse? = nil
    @Published var paymentMethod: Payment? = nil
        let item: ItemAddress = ItemAddress(name: "Nguyen thi Thanh Hien", phone: "01243242343", address: "213 chau tinh tri", contries: "Thanh xuan, Ha noi, Viet nam")
    let product: Product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", discount: 10, price: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
    static var instance = PaymentViewModel()
    func createPayment(amount: Double, addressDelivery: String, productId: Int?, color: String?, size: String?, quantity: Int?) {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.createPayment(amount: amount, addressDelivery: addressDelivery, productId: productId, color: color, size: size, quantity: quantity)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let payment = try filteredResponse.map(PaymentResponse.self)
                    self.payment = payment
                    print(payment)
                } catch { print("\(error.localizedDescription)")}
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    //Paypal
    @Published var state = CardPaymentState()
    
    let configManager = CoreConfigManager(domain: "Card Payments")
    
    private var cardClient: CardClient?
    
    func createOrder(
        amount: String,
        selectedMerchantIntegration: MerchantIntegration,
        intent: String,
        shouldVault: Bool,
        customerID: String? = nil
    ) async throws {
        
        let amountRequest = Amount(currencyCode: "USD", value: amount)
        // TODO: might need to pass in payee as payee object or as auth header
        
        var vaultPaymentSource: VaultCardPaymentSource?
        if shouldVault {
            var customer: CardVaultCustomer?
            if let customerID {
                customer = CardVaultCustomer(id: customerID)
            }
            let attributes = Attributes(vault: Vault(storeInVault: "ON_SUCCESS"), customer: customer)
            let card = VaultCard(attributes: attributes)
            vaultPaymentSource = VaultCardPaymentSource(card: card)
        }
        
        let orderRequestParams = CreateOrderParams(
            applicationContext: nil,
            intent: intent,
            purchaseUnits: [PurchaseUnit(amount: amountRequest)],
            paymentSource: vaultPaymentSource
        )
        
        do {
            DispatchQueue.main.async {
                self.state.createdOrderResponse = .loading
            }
            let order = try await DemoMerchantAPI.sharedService.createOrder(
                orderParams: orderRequestParams, selectedMerchantIntegration: selectedMerchantIntegration
            )
            DispatchQueue.main.async {
                self.state.createdOrderResponse = .loaded(order)
                print("✅ fetched orderID: \(order.id) with status: \(order.status)")
            }
        } catch {
            DispatchQueue.main.async {
                self.state.createdOrderResponse = .error(message: error.localizedDescription)
                print("❌ failed to fetch orderID: \(error)")
            }
        }
    }
    
    func captureOrder(orderID: String, selectedMerchantIntegration: MerchantIntegration) async throws {
        do {
            DispatchQueue.main.async {
                self.state.capturedOrderResponse = .loading
            }
            let order = try await DemoMerchantAPI.sharedService.captureOrder(
                orderID: orderID,
                selectedMerchantIntegration: selectedMerchantIntegration
            )
            DispatchQueue.main.async {
                self.state.capturedOrderResponse = .loaded(order)
            }
        } catch {
            DispatchQueue.main.async {
                self.state.capturedOrderResponse = .error(message: error.localizedDescription)
            }
            print("Error capturing order: \(error.localizedDescription)")
        }
    }
    
    func authorizeOrder(orderID: String, selectedMerchantIntegration: MerchantIntegration) async throws {
        do {
            DispatchQueue.main.async {
                self.state.authorizedOrderResponse = .loading
            }
            let order = try await DemoMerchantAPI.sharedService.authorizeOrder(
                orderID: orderID,
                selectedMerchantIntegration: selectedMerchantIntegration
            )
            DispatchQueue.main.async {
                self.state.authorizedOrderResponse = .loaded(order)
            }
        } catch {
            DispatchQueue.main.async {
                self.state.authorizedOrderResponse = .error(message: error.localizedDescription)
            }
            print("Error capturing order: \(error.localizedDescription)")
        }
    }
    
    func checkoutWith(card: Card, orderID: String, sca: SCA) async {
        do {
            DispatchQueue.main.async {
                self.state.approveResultResponse = .loading
            }
            let config = try await configManager.getCoreConfig()
            cardClient = CardClient(config: config)
            cardClient?.delegate = self
            let cardRequest = CardRequest(orderID: orderID, card: card, sca: sca)
            cardClient?.approveOrder(request: cardRequest)
        } catch {
            self.state.approveResultResponse = .error(message: error.localizedDescription)
            print("failed in checkout with card. \(error.localizedDescription)")
        }
    }
    
    func approveResultSuccessResult(approveResult: CardPaymentState.CardResult) {
        DispatchQueue.main.async {
            self.state.approveResultResponse = .loaded(
                approveResult
            )
        }
    }
    
    func setUpdateSetupTokenFailureResult(vaultError: CorePayments.CoreSDKError) {
        DispatchQueue.main.async {
            self.state.approveResultResponse = .error(message: vaultError.localizedDescription)
        }
    }
    
    // MARK: - Card Delegate
    
    func card(_ cardClient: CardPayments.CardClient, didFinishWithResult result: CardPayments.CardResult) {
        approveResultSuccessResult(
            approveResult: CardPaymentState.CardResult(
                id: result.orderID,
                deepLinkURL: result.deepLinkURL?.absoluteString
            )
        )
    }
    
    func card(_ cardClient: CardPayments.CardClient, didFinishWithError error: CorePayments.CoreSDKError) {
        print("Error here")
        DispatchQueue.main.async {
            self.state.approveResultResponse = .error(message: error.localizedDescription)
        }
    }
    
    func cardDidCancel(_ cardClient: CardPayments.CardClient) {
        print("Card Payment Canceled")
        DispatchQueue.main.async {
            self.state.approveResultResponse = .idle
            self.state.approveResult = nil
        }
    }
    
    func cardThreeDSecureWillLaunch(_ cardClient: CardPayments.CardClient) {
        print("About to launch 3DS")
    }
    
    func cardThreeDSecureDidFinish(_ cardClient: CardPayments.CardClient) {
        print("Finished 3DS")
    }
}
