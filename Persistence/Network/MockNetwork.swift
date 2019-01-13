//
//  Network.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Model

class MockNetwork {

    private let sessionManager: Alamofire.SessionManager
    private let userDefaults: UserDefaults

    init(
        sessionManager: Alamofire.SessionManager = Alamofire.SessionManager.default,
        userDefaults: UserDefaults = .standard) {
        self.sessionManager = sessionManager
        self.userDefaults = userDefaults
    }

    func request(endPoint: EndPointType) -> Observable<[Product]> {
        let delay = Int.random(in: 0..<5)
        guard
            let jsonFile = Bundle(for: MockNetwork.self).url(forResource: "products", withExtension: "json"),
            let data = try? Data(contentsOf: jsonFile),
            let products = try? JSONDecoder().decode([Product].self, from: data) else {
                return .empty()
        }
        return Observable.just(products)
            .delay(RxTimeInterval(delay), scheduler: MainScheduler.instance)
    }
}
