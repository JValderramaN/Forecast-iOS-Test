//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import Foundation
import CoreLocation

protocol ForecastViewModelDelegate {
    func loadForecastFinished(_ forecastViewModel: ForecastViewModel, forecast: Forecast?, error: Error?)
    func locationServiceRequired(_ forecastViewModel: ForecastViewModel)
}

class ForecastViewModel: NSObject {
    var delegate: ForecastViewModelDelegate?
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
    }
    
    private func handleLocation() {
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            delegate?.locationServiceRequired(self)
        }
    }
    
    func loadForecast() {
        APILayer.getForecastData { [weak self] (object, error) in
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.delegate?.loadForecastFinished(weakSelf, forecast: nil, error: error)
                return
            }
            
            guard let forecast = object as? Forecast else {
                let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Could not process Forecast data", comment: "")])
                 weakSelf.delegate?.loadForecastFinished(weakSelf, forecast: nil, error: error)
                return
            }
            
            weakSelf.delegate?.loadForecastFinished(weakSelf, forecast: forecast, error: nil)
        }
    }
}

extension ForecastViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            delegate?.locationServiceRequired(self)
        }
    }
}

