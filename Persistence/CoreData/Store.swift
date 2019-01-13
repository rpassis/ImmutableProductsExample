//
//  Repository.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol AbstractStore {
    associatedtype T
    func query(with predicate: NSPredicate?,
               sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

final class Store<T: CoreDataRepresentable>: AbstractStore where T == T.CoreDataType.ModelType {
    private let context: NSManagedObjectContext
    private let scheduler: ContextScheduler

    init(context: NSManagedObjectContext) {
        self.context = context
        self.scheduler = ContextScheduler(context: context)
    }

    func query(with predicate: NSPredicate? = nil,
               sortDescriptors: [NSSortDescriptor]? = nil) -> Observable<[T]> {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return context.rx.entities(fetchRequest: request)
            .mapToDomain()
            .subscribeOn(scheduler)
    }

    func save(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .map { _ in }
            .flatMapLatest(context.rx.save)
            .subscribeOn(scheduler)
    }

    func delete(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .map({$0 as! NSManagedObject})
            .flatMapLatest(context.rx.delete)
    }

}

extension Observable where Element: Sequence, Element.Iterator.Element: ModelConvertibleType {
    typealias ModelType = Element.Iterator.Element.ModelType

    func mapToDomain() -> Observable<[ModelType]> {
        return map { sequence -> [ModelType] in
            return sequence.mapToDomain()
        }
    }
}

extension Sequence where Iterator.Element: ModelConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.ModelType] {
        return map {
            return $0.asModel()
        }
    }
}

