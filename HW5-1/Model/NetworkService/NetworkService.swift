//
//  NetworkService.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    private init() { }
    
    func fetchProductsData(completion: @escaping (Result<MainProductModel, Error>) -> Void) {
        
        let request = URLRequest(url: Constants.API.baseURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            self.decodeData(data: data, completion: completion)
        }
        task.resume()
    }
    
    func decodeData<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
