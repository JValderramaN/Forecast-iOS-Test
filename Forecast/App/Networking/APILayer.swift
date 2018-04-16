//
//  APILayer.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CoreLocation

typealias ComplationHandler = (_ object: Any?, _ error: Error?) -> Void
let secretKey = "dd355c7232fb9751501144f9e9066fa6"

class APILayer {
    
    static func getForecastData(with locationCoordinate: CLLocationCoordinate2D, and complationHandler: @escaping ComplationHandler) {
        let url = "https://api.darksky.net/forecast/\(secretKey)/\(locationCoordinate.latitude),\(locationCoordinate.longitude)"
        
        Alamofire.request(url).responseObject { (response: DataResponse<Forecast>) in
            guard let forecast = response.result.value else {
                complationHandler(nil, response.error)
                return
            }

            complationHandler(forecast, response.error)
        }
    }
}
