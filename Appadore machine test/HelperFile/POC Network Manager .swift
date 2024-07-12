//
//  pocNetwork .swift
//  Appadore machine test
//
//  Created by Apple on 12/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//


import Foundation
import Combine

class POC_APIManager {
    static let shared = POC_APIManager()
    
    private init() {}
    
    private func request<T: Codable>(url: URL, method: String, body: Data? = nil, completion: @escaping (Result<T, APIError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    func get<T: Codable>(endpoint: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        request(url: url, method: "GET", completion: completion)
    }
    
    func post<T: Codable>(endpoint: String, body: [String: Any], completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request(url: url, method: "POST", body: jsonData, completion: completion)
        } catch {
            completion(.failure(.requestFailed(error)))
        }
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}
