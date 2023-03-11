//
//  WebServices.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation

enum APIServiceError: Error {
    case apiError(errorMessage: String?)
    case decodeError
    
    func errorMessage() -> String {
        switch self {
        case .apiError(errorMessage: let errorMessage):
            return errorMessage ?? "Network Error"
        case .decodeError:
            return "Decode Error"
        }
    }
}

class WebServices: NSObject {

    static let shared = WebServices()
    private override init() {}
    
    // MARK: - Get Request
    func getRequestDetails<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, APIServiceError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if error != nil {
                    completionHandler(.failure(.apiError(errorMessage: error?.localizedDescription)))
                }
                return
            }
            do {
                let newsData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(newsData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}
