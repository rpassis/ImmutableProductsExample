//
//  CoreDataRepresentable.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable

    var uuid: String {get}

    func update(entity: CoreDataType)
}

extension CoreDataRepresentable {
    func sync(in context: NSManagedObjectContext) -> Observable<CoreDataType> {
        return context.rx.sync(entity: self, update: update)
    }
}
