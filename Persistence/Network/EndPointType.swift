//
//  EndPointType.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import Alamofire

typealias HTTPHeaders = [String: String]

enum AuthorizationType {
    case authorization
    case none
}

protocol AccessTokenAuthorizable {
    var authorizationType: AuthorizationType { get }
}

protocol EndPointType: URLRequestConvertible, AccessTokenAuthorizable {
    var baseURL: String { get }
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var path: String { get }
    var sampleData: Data? { get }
}
