//
//  NSManagedObject.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

extension NSManagedObjectContext {
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription.insertNewObject(
            forEntityName: String(describing: T.self),
            into: self) as? T else {
                fatalError()
        }
        return entity
    }
}
