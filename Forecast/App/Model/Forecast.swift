//
//  Forecast.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import Foundation
import ObjectMapper

class Forecast: Mappable, CustomStringConvertible {
    
    var latitude: Double?
    var longitude: Double?
    var summary: String?
    var icon: String?
    var precipProbability: Double?
    var temperature: Double?
    var humidity: Double?
    
    var description: String {
        guard let latitude = latitude, let longitude = longitude, let summary = summary, let temperature = temperature else {
            return "No description for Forecast!"
        }
        
        return "Forecast: \(latitude),\(longitude) - \(summary) \(temperature)"
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        summary <- map["currently.summary"]
        icon <- map["currently.icon"]
        precipProbability <- map["currently.precipProbability"]
        temperature <- map["currently.temperature"]
        humidity <- map["currently.humidity"]
    }
}
