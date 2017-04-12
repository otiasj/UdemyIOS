//
//  PokedexCacheApiService.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class PokedexCacheApiService: ApiService {
    
    let preferences: Preferences
    
    init(preferences: Preferences) {
        self.preferences = preferences
    }
    
    /**
     * Load some data from cache
     */
    func load(withParams: [String: Any?]?) -> Observable<PokedexEntity>{
        let observable = Observable<PokedexEntity>.create { observer in
            let disposable = workScheduler.schedule(()) {
                self.customcacheWork(observer : observer, withParams: withParams)
                return workScheduler.schedule(()) {
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            return Disposables.create {
                //clean up if any
                disposable.dispose()
            }
        }
        return observable
    }
    
    internal func customcacheWork(observer: AnyObserver<PokedexEntity>, withParams: [String: Any?]?) {
        if let data = UserDefaults.standard.data(forKey: "pokedex"),
            let pokedexEntity = NSKeyedUnarchiver.unarchiveObject(with: data) as? PokedexEntity {
            print("Using cache!")
            return observer.onNext(pokedexEntity)
        }
    }
    
    func store(_ value: PokedexEntity, withParams: [String: Any?]?) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(encodedData, forKey: "pokedex")
    }
    
    func clear(_ withParams: [String: Any?]?) {
        UserDefaults.standard.removeObject(forKey: "pokedex")
    }

}
