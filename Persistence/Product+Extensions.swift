//
//  Product+Extensions.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import Model

extension Product: CoreDataRepresentable {

    typealias CoreDataType = ProductEntity

    func update(entity: CoreDataType) {
        entity.uuid = uuid
        entity.title = title
    }
}

