//
//  RepositoryProvider.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import Model

public enum RepositoryProvider {

    private static let stack = CoreDataStack()

    public static func makeRepository() -> ProductRepositoryType {
        let context = stack.newWorkerContext()
        let store = Store<Product>(context: context)
        let network = MockNetwork()
        return ProductRepository(network: network, store: store)
    }
}
