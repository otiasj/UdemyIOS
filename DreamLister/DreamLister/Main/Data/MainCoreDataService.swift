//
//  MainCacheApiService.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift
import CoreData

protocol OnDataUpdateListener {
    func onBeginUpdate()
    func onEndUpdate()
    func onInsert(indexPath: IndexPath?)
    func onDelete(indexPath: IndexPath?)
    func onUpdate(indexPath: IndexPath?)
}

class MainCoreDataService: NSObject, ApiService, NSFetchedResultsControllerDelegate {
    
    var onDataUpdateListener: OnDataUpdateListener
    var fetchedResultsController: NSFetchedResultsController<Item>!
    private var loadObserver: AnyObserver<MainEntity>?
    
    
    init(onDataUpdateListener: OnDataUpdateListener) {
        self.onDataUpdateListener = onDataUpdateListener
    }
    
    func setUpdateListener(onDataUpdateListener: OnDataUpdateListener) {
        self.onDataUpdateListener = onDataUpdateListener
    }
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        return Observable<MainEntity>.create { observer in
            self.loadObserver = observer
            self.attemptFetch()
            return Disposables.create()
        }
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
            print("fetch success: \(fetchedResultsController.fetchedObjects?.count)")
            loadObserver?.onNext(MainEntity(sections: fetchedResultsController.sections!, itemGetter: fetchedResultsController))
            loadObserver?.onCompleted()
        } catch {
            let error = error as NSError
            print("\(error)")
            loadObserver?.onError(error)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onDataUpdateListener.onBeginUpdate()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onDataUpdateListener.onEndUpdate()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case.insert:
            if let indexPath = newIndexPath {
                onDataUpdateListener.onInsert(indexPath: indexPath)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                onDataUpdateListener.onDelete(indexPath: indexPath)
            }
            break
        case.update:
            if let indexPath = indexPath {
                onDataUpdateListener.onUpdate(indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                onDataUpdateListener.onDelete(indexPath: indexPath)
            }
            if let indexPath = newIndexPath {
                onDataUpdateListener.onInsert(indexPath: indexPath)
            }
            break
        }
    }
}
