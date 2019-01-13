//
//  Repository.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import RxSwift
import Model

public protocol ProductRepositoryType {
    func fetchProducts() -> Observable<[Product]>
    func fetchAny() -> Observable<Product>
    func save(_ product: Product) -> Observable<Void>
}

struct ProductRepository: ProductRepositoryType {

    private let network: MockNetwork
    private let store: Store<Product>

    init(network: MockNetwork, store: Store<Product>) {
        self.network = network
        self.store = store
    }

    func fetchProducts() -> Observable<[Product]> {
        let local = store.query(sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)])
        let remote: Observable<[Product]> = network.request(endPoint: ProductEndpoint.fetchAll)
        let saved = remote
            .flatMapLatest { products -> Observable<[Product]> in
                let o = products.map { product in self.store.save(entity: product).map { product } }
                return Observable.merge(o).toArray()
            }

        return Observable.merge(local, saved)//.debug("--repoMerge--", trimOutput: true)
    }

    func fetchAny() -> Observable<Product> {
        return store
            .query(sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)])
            .map { products in
                let rand = Int.random(in: 0..<products.count)
                return products[rand]
            }
            .take(1)
    }

    func save(_ product: Product) -> Observable<Void> {
        return self.store.save(entity: product)
    }

}
