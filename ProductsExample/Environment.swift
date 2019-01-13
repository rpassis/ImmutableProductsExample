//
//  Environment.swift
//  ProductsExample
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import Persistence

struct Environment {

    var productRepository: ProductRepositoryType

    init(productRepository: ProductRepositoryType = RepositoryProvider.makeRepository()) {
        self.productRepository = productRepository
    }
}
