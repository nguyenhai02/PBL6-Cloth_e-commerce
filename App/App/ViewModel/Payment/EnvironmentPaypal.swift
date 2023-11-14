import CorePayments

enum EnvironmentPaypal: String, CaseIterable {
    case sandbox

    var baseURL: String {
        switch self {
        case .sandbox:
            return "https://sdk-sample-merchant-server.herokuapp.com"
        }
    }

    var paypalSDKEnvironment: CorePayments.Environment {
        switch self {
        case .sandbox:
            return .sandbox
        }
    }
}
