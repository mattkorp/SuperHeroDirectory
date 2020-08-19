//
//  Request.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ResultVoidClosure<T> = (Result<T, Error>) -> Void

// Encoding

public enum Encoding {
    case json
    case url
}

// HTTPMethod

public enum HTTPMethod {
    case get
    case post(Encoding)

    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

// RequestType - declaration

protocol RequestType {

    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }

    func responseObject<T: Decodable>() -> Promise<T>
}

// Request - Public properties
// RequestType - implementation

public struct Request: RequestType {
    let url: URL
    let method: HTTPMethod
    let parameters: Parameters?
    let headers: HTTPHeaders?
}

// Request - public method

public extension Request {

    func responseObject<T: Decodable>() -> Promise<T> {
        let promise = Promise<T>()
        self.response()
            .onSuccess { data in
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    promise.fulfill(model)
                } catch (let error) {
                    promise.reject(HTTPError.decodingError(underlying: error))
                }
            }
            .onFailure(promise.reject)
        
        return promise
    }
}

// Request - private

private extension Request {

    func response() -> Promise<Data> {
        let promise = Promise<Data>()
        URLSession.shared.dataTask(with: self.asURLRequest()) { (data, response, error) in
            if let error = error {
                promise.reject(self.converted(error))
            } else {
                let httpResponse = response as! HTTPURLResponse
                if (200 ... 299) ~= httpResponse.statusCode {
                    guard let data = data else {
                        promise.reject(HTTPError.noData)
                        return
                    }
                    promise.fulfill(data)
                } else {
                    promise.reject(HTTPError.serverError(response: response))
                }
            }
        }.resume()
        
        return promise
    }

    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if case let .post(encoding) = method {
            switch encoding {
            case .json:
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            case .url:
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }
        if let params = parameters {
            switch method {
            case .post(let encoding):
                switch encoding {
                case .json:
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params)
                case .url:
                    request.httpBody = params.map { (tuple) -> String in
                        return "\(tuple.key)=\(self.percentEscapeString(string: "\(tuple.value)"))"
                        }.joined(separator: "&").data(using: .utf8, allowLossyConversion: true)
                }
            case .get:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                components.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                let urlWithQueries = components.url!
                request.url = urlWithQueries
            }
        }
        request.httpMethod = method.value

        return request
    }

    func converted(_ error: Error) -> Error {
        if let error = error as? URLError {
            switch error.code {
            case .timedOut,
                 .cannotFindHost,
                 .networkConnectionLost,
                 .dnsLookupFailed,
                 .notConnectedToInternet,
                 .cannotConnectToHost:
                return HTTPError.unreachable
            default:
                break
            }
        }

        return HTTPError.clientError(underlying: error)
    }

    func percentEscapeString(string: String) -> String {
        string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    var characterSet: CharacterSet {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        return characterSet
    }
}
