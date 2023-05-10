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
    
    func fetchProductsData() async throws -> MainProductModel {
        let request = URLRequest(url: Constants.API.baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
