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

class ItemCoreDataService: NSObject, ApiService, NSFetchedResultsControllerDelegate {
    
    var onDataUpdateListener: OnDataUpdateListener?
    var fetchedResultsController: NSFetchedResultsController<Item>!
    private var loadObserver: AnyObserver<MainEntity>?
    
    
    init(onDataUpdateListener: OnDataUpdateListener?) {
        self.onDataUpdateListener = onDataUpdateListener
    }
    
    override init() {
        
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
    
    func save(detailsEntity: DetailsEntity) {
        let item = Item(context: context)
        item.title = detailsEntity.title
        item.details = detailsEntity.details
        item.price = detailsEntity.price
        item.toStore = detailsEntity.store
        item.toImage = detailsEntity.toImage
        appDelegate.saveContext()
    }
    
    func delete(item: Item) {
        context.delete(item)
        appDelegate.saveContext()
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
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
        if let onDataUpdateListener = onDataUpdateListener {
        onDataUpdateListener.onBeginUpdate()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let onDataUpdateListener = onDataUpdateListener {
        onDataUpdateListener.onEndUpdate()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case.insert:
            if let indexPath = newIndexPath {
                if let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onInsert(indexPath: indexPath)
                }
            }
            break
        case.delete:
            if let indexPath = indexPath {
                if let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onDelete(indexPath: indexPath)
                }
            }
            break
        case.update:
            if let indexPath = indexPath, let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onUpdate(indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath, let onDataUpdateListener = onDataUpdateListener  {
                onDataUpdateListener.onDelete(indexPath: indexPath)
            }
            if let indexPath = newIndexPath, let onDataUpdateListener = onDataUpdateListener  {
                onDataUpdateListener.onInsert(indexPath: indexPath)
            }
            break
        }
    }
}
