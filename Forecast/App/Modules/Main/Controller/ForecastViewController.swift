//
//  ForecastViewController.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForecastViewController: UIViewController {
    
    @IBOutlet fileprivate weak var humidityLabel: UILabel!
    @IBOutlet fileprivate weak var rainLabel: UILabel!
    @IBOutlet fileprivate weak var refreshButton: UIButton!
    @IBOutlet fileprivate weak var temperatureLabel: UILabel!
    @IBOutlet fileprivate weak var summaryTextView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    fileprivate let forecastViewModel: ForecastViewModel = ForecastViewModel() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        forecastViewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func loadData() {
        refreshButton.isEnabled = false
        SVProgressHUD.show()
        forecastViewModel.loadForecast()
    }
    
    fileprivate func fillUI(with forecast: Forecast?) {
        guard let forecast = forecast else {
            return
        }
        
        temperatureLabel.text = "\(forecast.temperature ?? 0)°"
        humidityLabel.text = "\((forecast.humidity ?? 0) * 100)%"
        rainLabel.text = "\((forecast.precipProbability ?? 0) * 100)%"
        summaryTextView.text = "\(forecast.summary ?? "")"
        
        if let icon = forecast.icon {
            iconImageView.image = UIImage(named: icon)
        } else {
            iconImageView.image = nil
        }
    }

    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        loadData()
    }
}

extension ForecastViewController: ForecastViewModelDelegate {
    func locationServiceRequired(_ forecastViewModel: ForecastViewModel) {
        let alert = UIAlertController.alertWithAcceptButton(message: NSLocalizedString("Please allow the location service for this app in order to work properly", comment: ""))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadForecastFinished(_ forecastViewModel: ForecastViewModel, forecast: Forecast?, error: Error?) {
        SVProgressHUD.dismiss()
        self.refreshButton.isEnabled = true
        guard error == nil else {
            let alert = UIAlertController.alertWithAcceptButton(message: error?.localizedDescription)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.fillUI(with: forecast)
    }
}

