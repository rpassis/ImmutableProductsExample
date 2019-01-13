//
//  ProductEndPoint.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import Alamofire

enum ProductEndpoint: EndPointType {

    case fetchAll

    var baseURL: String { return "" }

    var headers: HTTPHeaders? { return nil }

    var method: HTTPMethod { return .get }

    var parameters: Parameters? { return nil }

    var path: String { return "" }

    var sampleData: Data? { return nil }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }

    var authorizationType: AuthorizationType { return .none }
}
