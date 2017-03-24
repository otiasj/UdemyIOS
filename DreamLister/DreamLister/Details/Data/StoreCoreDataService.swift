//
//  DetailsCacheApiService.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift
import CoreData

class StoreCoreDataService: ApiService {
    
    var loadObserver: AnyObserver<[Store]>?
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary) -> Observable<[Store]>{
        return Observable<[Store]>.create { observer in
            self.loadObserver = observer
            self.attemptFetch()
            return Disposables.create()
        }
    }
    
    func attemptFetch() {
        let fetchRequest:NSFetchRequest<Store> = Store.fetchRequest()
        do {
            let stores = try context.fetch(fetchRequest)
            loadObserver?.onNext(stores)
            loadObserver?.onCompleted()
        } catch {
            let error = error as NSError
            print("\(error)")
            loadObserver?.onError(error)
        }
    }
    
}
