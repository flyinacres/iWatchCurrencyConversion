//
//  detailInterfaceController.swift
//  CurrencyConverter
//
//  Created by Ronald Fischer on 10/11/15.
//  Copyright (c) 2015 qpiapps. All rights reserved.
//

import WatchKit
import Foundation


class detailInterfaceController: WKInterfaceController {
    var conversionRate = 0.75
    var curValue:Float = 0.05

    @IBOutlet weak var dollarsLabel: WKInterfaceLabel!
    
    @IBOutlet weak var conversionAmount: WKInterfaceLabel!
    
    @IBOutlet weak var currencyLabel: WKInterfaceLabel!
    
    @IBAction func conversionAmount(value: Float) {
        curValue = value
        updateAmount()
    }
    
    func updateAmount() {
        var numDollars = Int(curValue * 20)
        dollarsLabel.setText("\(numDollars) USD equals:")
        conversionAmount.setText("\(Double(numDollars) * currencyConversions[activeCurrency])")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        currencyLabel.setText(currencies[activeCurrency])
        updateAmount()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
