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
    
    var fetchedResultsController: NSFetchedResultsController<Item>!
    var onDataUpdateListener: OnDataUpdateListener?
    
    func setUpdateListener(onDataUpdateListener: OnDataUpdateListener) {
        self.onDataUpdateListener = onDataUpdateListener
    }
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        //FIXME this is returning a mock response
        return Observable<MainEntity>.just(MainEntity(loadedFrom: "Cache"))
        //        return Observable<TestEntity>.empty() //emulate no cache
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
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
            if let indexPath = newIndexPath, let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onInsert(indexPath: indexPath)
            }
            break
        case.delete:
            if let indexPath = indexPath, let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onDelete(indexPath: indexPath)
            }
            break
        case.update:
            if let indexPath = indexPath, let onDataUpdateListener = onDataUpdateListener {
                onDataUpdateListener.onUpdate(indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath, let onDataUpdateListener = onDataUpdateListener {
                //tableView.deleteRows(at: [indexPath], with: .fade)
                onDataUpdateListener.onDelete(indexPath: indexPath)
            }
            if let indexPath = newIndexPath, let onDataUpdateListener = onDataUpdateListener {
                //tableView.insertRows(at: [indexPath], with: .fade)
                onDataUpdateListener.onInsert(indexPath: indexPath)
            }
            break
        }
    }
}
