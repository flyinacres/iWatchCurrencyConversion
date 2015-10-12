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

class InterfaceController: WKInterfaceController, NSXMLParserDelegate {


    @IBOutlet weak var currencyLabel: WKInterfaceLabel!
    
    @IBAction func currencyChooser(value: Float) {
        var i = Int(value * 3)
        currencyLabel.setText(currencies[i])
        activeCurrency = i
    }

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let url = NSURL(string: "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            if error == nil {
                println(NSString(data:  data, encoding: NSUTF8StringEncoding))
                var xmlParser = NSXMLParser(data:data)
                xmlParser.delegate = self
                xmlParser.parse()
                
            } else {
                println(error)
            }
        })
        
        task.resume()

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    var element = ""
    var nameAttribute = ""
    var getCurrency = -1
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        element = elementName
        if attributeDict["name"] != nil {
            nameAttribute = attributeDict["name"] as! String
        } else {
            nameAttribute = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if element == "field" && nameAttribute == "name" {
            for (index, currency) in enumerate(currencies) {
                if string == "USD/" + currency {
                    getCurrency = index
                }
            }
            
        }
        if element == "field" && nameAttribute == "price" && getCurrency != -1 {
            println("Found one")
            println(string)
            currencyConversions[getCurrency] = (string! as NSString).doubleValue
            getCurrency = -1
        }
    }

}
