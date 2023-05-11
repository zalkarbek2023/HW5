//
//  ViewModel.swift
//  HW5-1
//
//  Created by zalkarbek on 11/5/23.
//

import UIKit

class ViewModel {
    
    let networkService: NetworkLayer
    
    init() {
        self.networkService = NetworkLayer()
    }
    
    func fetchProducts() async throws -> [ProductModel] {
        try await networkService.fetchProductsData().products
    }
    
}
