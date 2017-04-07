//
//  MainNetworkApiService.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift
import Alamofire

class MainNetworkApiService: ApiService {
    typealias T = MainEntity
    typealias P = NSDictionary
    
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
    let LATITUDE = "lat="
    let LONGITUDE = "lon="
    let APP_ID = "appid="
    let API_KEY = "0f3f4bc9aea43c795f75e7bb14c3f6fe"
    
    /**
     * Load some data from the network
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        return Observable<MainEntity>.create { observer in
            let disposable = workScheduler.schedule(()) {
                
                if let latitude = withParams.value(forKey: "latitude") as! Double?,
                    let longitude = withParams.value(forKey: "longitude") as! Double?
                {
                    let url = self.createUrl(latitude: latitude, longitude: longitude)
                    self.loadWeather(observer: observer, url: url)
                } else {
                    observer.onError(NSError(domain: "Missing parameters", code: 422))
                }
                
                return workScheduler.schedule(()) {
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func createUrl(latitude: Double, longitude: Double) -> URL {
        return URL(string: "\(BASE_URL)?\(LATITUDE)\(latitude)&\(LONGITUDE)\(longitude)&\(APP_ID)\(API_KEY)")!
    }
    
    func loadWeather(observer: AnyObserver<MainEntity>, url: URL) {
        print("loading \(url)")
        
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            
            if result.isSuccess {
                print(response)
                let mainEntity = self.parseResult(responseValue: response.value as! Dictionary<String, AnyObject>)
                observer.onNext(mainEntity)
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
    
    func parseResult(responseValue: Dictionary<String, AnyObject>) -> MainEntity {
        let resultEntity = MainEntity()
        if let name = responseValue["name"] as? String {
            resultEntity.cityName = name
        }
        
        if let weather = responseValue["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather.first?["main"] as? String {
                resultEntity.weatherType = main.capitalized
            }
        }
        
        if let main = responseValue["main"] as? Dictionary<String, AnyObject> {
            resultEntity.currentTemperatureInKelvin = main["temp"] as? Double
        }
        
        //set download date to now
        resultEntity.downloadedDate = Date()
        return resultEntity
    }
    
    typealias MyResponse = () -> ()
}
