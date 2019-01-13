//
//  ProductEntity.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData
import Model

@objc(ProductEntity)
final class ProductEntity: NSManagedObject {
    @NSManaged public var uuid: String?
    @NSManaged public var title: String?
}

extension ProductEntity: Persistable {
    static func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    static var entityName: String { return "ProductEntity" }
}

extension ProductEntity: ModelConvertibleType {
    typealias ModelType = Product

    func asModel() -> ModelType {
        let uuid = self.uuid ?? "Unknown"
        let title = self.title ?? "Untitled"
        return Product(uuid: uuid, title: title)
    }
}
