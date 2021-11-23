import Foundation

//public class SharedRequestBuilder {
//
//    enum Method: String {
//        case get = "GET"
//        case post = "POST"
//        case put = "PUT"
//        case delete = "DELETE"
//    }
//
//    enum SharedRequestBuilderError: Swift.Error {
//        case cannotCastToUrl
//        case codingError(Swift.Error)
//    }
//
//    static func buildRequest<Type: Encodable>(
//        stringUrl: String,
//        method: Method,
//        body: Type.Type
//    ) throws -> URLRequest {
//
//        guard let url = URL(string: stringUrl)
//        else {
//            throw SharedRequestBuilderError.cannotCastToUrl
//        }
//
//        var request: URLRequest = URLRequest(url: url)
//        request.setValue(
//            "application/json; charset=utf-8",
//            forHTTPHeaderField: "Content-Type"
//        )
//        request.httpMethod = method.rawValue
//
//        if let body = body {
//            request.httpBody = try jsonEncoder.encode(body)
//        }
//
//        return request
//    }
//}
