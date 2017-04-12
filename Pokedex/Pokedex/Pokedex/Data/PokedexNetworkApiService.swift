//
//  PokedexNetworkApiService.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift
import Alamofire

class PokedexNetworkApiService: NetworkApiService {
    typealias T = PokedexEntity
    typealias P = [String: Any?]?

    /**
     * Load some data from the network
     */
    func load(withParams: [String: Any?]?) -> Observable<PokedexEntity>{
        let observable = Observable<PokedexEntity>.create { observer in
            let disposable = workScheduler.schedule(()) {
                self.netWork(observer : observer, withParams: withParams)
                return Disposables.create()
            }
            return Disposables.create {
                //clean up if any
                disposable.dispose()
            }
        }
        return observable
    }
    
    
    //FIXME Implement your custom api work here
    func netWork(observer: AnyObserver<PokedexEntity>, withParams: [String: Any?]?) {
        let url = self.createUrl(withParams)
        debugPrint("Requesting \(url)")
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            
            if result.isSuccess {
                debugPrint("Received Response \(response)")
                let pokedex = self.parseResult(response.value as! Dictionary<String, AnyObject>)
                observer.onNext(pokedex)
                observer.onCompleted()
            } else {
                if let error = result.error {
                    observer.onError(error)
                } else {
                    observer.onError(NSError(domain: "Unknown network error", code: 500))
                }
            }
        }
    }
    
    func createUrl(_ parameters: ([String: Any?])?) -> URL {
        return URL(string: "fixme, build URL here")!
    }
    
    func createParameters() -> [String: Any]? {
        return nil
    }
    
    func createHeaders() -> [String: String] {
        return createDefaultHeaders()
    }
    
    func parseResult(_ responseValue: [String: Any?]) -> PokedexEntity {
        let result = PokedexEntity(loadedFrom: "Network")
        //FIXME do parsing of responseValue into result
        return result
    }
    
}
