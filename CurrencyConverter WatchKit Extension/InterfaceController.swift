//
//  InterfaceController.swift
//  CurrencyConverter WatchKit Extension
//
//  Created by Ronald Fischer on 10/11/15.
//  Copyright (c) 2015 qpiapps. All rights reserved.
//

import WatchKit
import Foundation

var activeCurrency = 0
var currencies = ["GBP", "EUR", "JPY", "CAD"]
var currencyConversions = [0.74, 0.93, 0.4, 1.24]

class InterfaceController: WKInterfaceController {


    @IBOutlet weak var currencyLabel: WKInterfaceLabel!
    
    @IBAction func currencyChooser(value: Float) {
        var i = Int(value * 3)
        currencyLabel.setText(currencies[i])
        activeCurrency = i
    }

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}