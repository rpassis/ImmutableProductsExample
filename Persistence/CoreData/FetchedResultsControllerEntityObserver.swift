//
//  Fetched.swift
//  Persistence
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

final class ContextScheduler: ImmediateSchedulerType {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {

        let disposable = SingleAssignmentDisposable()

        context.perform {
            if disposable.isDisposed {
                return
            }
            disposable.setDisposable(action(state))
        }

        return disposable
    }
}

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult> : NSObject, NSFetchedResultsControllerDelegate {

    typealias Observer = AnyObserver<[T]>

    private let observer: Observer
    private let frc: NSFetchedResultsController<T>


    init(observer: Observer, fetchRequest: NSFetchRequest<T>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName: String?) {
        self.observer = observer


        self.frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                              managedObjectContext: context,
                                              sectionNameKeyPath: sectionNameKeyPath,
                                              cacheName: cacheName)
        super.init()

        context.perform {
            self.frc.delegate = self

            do {
                try self.frc.performFetch()
            } catch let e {
                observer.on(.error(e))
            }

            self.sendNextElement()
        }
    }

    private func sendNextElement() {
        self.frc.managedObjectContext.perform {
            let entities = self.frc.fetchedObjects ?? []
            self.observer.on(.next(entities))
        }
    }

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }

}

extension FetchedResultsControllerEntityObserver : Disposable {

    func dispose() {
        frc.delegate = nil
    }

}


