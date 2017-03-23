//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  This is used by all observable that needs to do some background work and post the result on the main thread
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

//public to allow override in test
public var useDefaultSchedulers = false
public var defaultScheduler: SchedulerType = MainScheduler.instance
public var workScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .default)

extension ObservableType {
    
    /**
     Makes the observable Subscribe to io thread and Observe on main thread
     */
    public func composeIoToMainThreads() -> Observable<E> {
        if (useDefaultSchedulers) {
            return self.asObservable()
        } else {
            return self.subscribeOn(workScheduler)
                .observeOn(defaultScheduler)
        }
    }
    
}
