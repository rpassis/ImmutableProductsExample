//
//  ModelConvertible.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation

protocol ModelConvertibleType {
    associatedtype ModelType
    func asModel() -> ModelType
}
