//
//  Persistable.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData

protocol Persistable: NSFetchRequestResult, ModelConvertibleType {
    static var entityName: String {get}
    static func fetchRequest() -> NSFetchRequest<Self>
}

extension Persistable {
    static var primaryAttribute: String {
        return "uuid"
    }
}

