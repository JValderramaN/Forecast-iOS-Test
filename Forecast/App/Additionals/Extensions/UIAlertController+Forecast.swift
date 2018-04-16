//
//  UIAlertController+Forecast.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func alertWithAcceptButton(title: String? = NSLocalizedString("Error", comment: ""),
                                    message: String? = NSLocalizedString("An error has occurred", comment: "")) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        return alert
    }
}
