//
//  NetworkClient.swift
//  Networking
//
//  Created by djiang on 10/10/21.
//

import Alamofire
import Foundation
import Controls

public enum Certificates {
    public static let stackExchange = Certificates.certificate(filename: "stackexchange.com")

    private static func certificate(filename: String) -> SecCertificate? {
        guard let filePath = Bundle.Networking.path(forResource: filename, ofType: "der"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let certificate = SecCertificateCreateWithData(nil, data as CFData) else { return nil }

        return certificate
    }
}

public final class NetworkClient {
    let session: Session
    let evaluators = [
        "api.stackexchange.com": PinnedCertificatesTrustEvaluator(certificates: [Certificates.stackExchange!])
    ]

    private init() {
//        #if DEBUG
        session = Session()
//        #else
//        session = Session(serverTrustManager: ServerTrustManager(evaluators: evaluators))
//        #endif
    }

    private static let shared = NetworkClient()

    static func request(_ convertible: URLRequestConvertible) -> DataRequest {
        return shared.session.request(convertible)
    }

    public static func get<Success: Codable>(api: URLRequestConvertible, type: Success.Type, success: ((Success) -> Void)?, failure: ((Error) -> Void)? = nil) {
        NetworkClient.request(api)
            .responseDecodable { (response: DataResponse<Success, AFError>) in
                switch response.result {
                case .success(let value):
                    success?(value)
                case .failure(let error):
                    failure?(error) ?? showError(error)
                }
            }
    }
}

extension NetworkClient {
    static func showError(_ error: Error) {
        let isServerTrustEvaluationError =
            error.asAFError?.isServerTrustEvaluationError ?? false
        let message: String
        if isServerTrustEvaluationError {
            message = "Certificate Pinning Error"
        } else {
            message = error.localizedDescription
        }
        EZAlert.presentError(message: message)
    }
}
