//
//  NetworkManager.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import Foundation

enum NetworkErrors: Error {
    case error(error: String)
    case invalidResponse(response: String)
    case invalidData
    case decodingError(erorr: String)
}

final class NetworkManager<T : Codable> {
    func fetch(url: URL, completion: @escaping (Result < T, NetworkErrors >) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.error(error: error!.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse(response: response!.description)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                print(json)
               
                completion(.success(json))
            }catch let error {
                completion(.failure(.decodingError(erorr: error.localizedDescription)))
                print(error.localizedDescription)
            }
        }
        .resume()
        
    }
}
