//
//  ForecastNetworkApiService.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/5/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation


//
//  MainNetworkApiService.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift
import Alamofire

class ForecastNetworkApiService: ApiService {
    typealias T = [Forecast]
    typealias P = NSDictionary
    
    let BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    let LATITUDE = "lat="
    let LONGITUDE = "lon="
    let APP_ID = "appid="
    let COUNT = "cnt="
    let API_KEY = "0f3f4bc9aea43c795f75e7bb14c3f6fe"
    
    /**
     * Load some data from the network
     */
    func load(withParams: NSDictionary) -> Observable<[Forecast]>{
        return Observable<[Forecast]>.create { observer in
            
            if let latitude = withParams.value(forKey: "latitude") as! Double?,
                let longitude = withParams.value(forKey: "longitude") as! Double?,
                let days = withParams.value(forKey: "forecastDayCount") as! Int?
            {
                let url = self.createUrl(latitude: latitude, longitude: longitude, count: days)
                self.loadWeather(observer: observer, url: url)
                
            } else {
                observer.onError(NSError(domain: "Missing parameters in NSDictionnary", code: 422))
            }
            return Disposables.create()
        }
    }
    
    func createUrl(latitude: Double, longitude: Double, count: Int) -> URL {
        return URL(string: "\(BASE_URL)?\(LATITUDE)\(latitude)&\(LONGITUDE)\(longitude)&\(COUNT)\(count)&\(APP_ID)\(API_KEY)")!
    }
    
    func loadWeather(observer: AnyObserver<[Forecast]>, url: URL) {
        print("loading \(url)")
        
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            
            if result.isSuccess {
                print(response)
                var forecasts = self.parseResult(responseValue: response.value as! Dictionary<String, AnyObject>)
                forecasts.removeFirst(1) // the first element is current weather, which we already display in the main view
                observer.onNext(forecasts)
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
    
    func parseResult(responseValue: Dictionary<String, AnyObject>) -> [Forecast] {
        var resultForcasts = [Forecast]()
        
        if let forecastList = responseValue["list"] as? [Dictionary<String, AnyObject>] {
            for forecastInfo in forecastList {
                let forecast = Forecast()
                
                if let date = forecastInfo["dt"] as? Double {
                    forecast.dateUnixTimestamp = Date(timeIntervalSince1970: date)
                }
                
                if let temperatures = forecastInfo["temp"] as? Dictionary<String, AnyObject> {
                    forecast.highTemperatureInKelvin = temperatures["max"] as? Double
                    forecast.lowTemperatureInKelvin = temperatures["min"] as? Double
                }
                
                if let weather = forecastInfo["weather"] as? [Dictionary<String, AnyObject>] {
                    forecast.weatherTypeDescription = weather.first?["description"] as? String
                    forecast.weatherType = weather.first?["main"] as? String
                }
                
                resultForcasts.append(forecast)
            }
        }
        return resultForcasts
    }
    
    typealias MyResponse = () -> ()
}
