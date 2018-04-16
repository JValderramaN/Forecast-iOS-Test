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

typealias ComplationHandler = (_ object: Any?, _ error: Error?) -> Void

class APILayer {
    
    static func getForecastData(with complationHandler: @escaping ComplationHandler) {
        
        // TODO: pedir latitud y longitud
        
        let url = "https://api.darksky.net/forecast/dd355c7232fb9751501144f9e9066fa6/37.8267,-122.4233"
        
        Alamofire.request(url).responseObject { (response: DataResponse<Forecast>) in
            guard let forecast = response.result.value else {
                complationHandler(nil, response.error)
                return
            }

            complationHandler(forecast, response.error)
        }
    }
}
