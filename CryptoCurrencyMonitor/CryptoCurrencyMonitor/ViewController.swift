//
//  ViewController.swift
//  CryptoCurrencyMonitor
//
//  Created by Gabriel Equitz on 4/15/19.
//  Copyright © 2019 Gabriel Equitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var currencyConversion: UILabel!
    
    var cryptoCurrency:  [String] = []
    
    var currency:  [String] = []
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cryptoCurrency = [ "BTC", "ETH", "XRP", "BCH", "XLM", "EOS", "LTC", "ADA", "XMR", "TRX"]
        
        currency = ["USD", "EUR", "JPY", "GBP", "CHF", "CAD", "AUD" ]
        
        
        
        
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if( component == 0){
            
            return cryptoCurrency.count;
            
        }
            
        else{
            
            return currency.count;
            
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (component == 0) {
            
            return cryptoCurrency[row];
            
        }
            
        else{
            
            return currency[row];
            
        }
        
    }
    
    //https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,JPY,EUR
    
    func getCurrencyPrice(cryptoCurrency: String, currency: String){
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=" + cryptoCurrency + "&tsyms=" + currency){
            
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                if let data = data {
                    
                    
                    
                    
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String:Double]{
                        
                        DispatchQueue.main.async {  // runs the code in the main thread
                            
                            // print (json)
                            
                            // print (type (of: json))
                            
                            if let price = json[currency] {
                                
                                
                                
                                let formatter = NumberFormatter()
                                
                                formatter.currencyCode = currency
                                
                                formatter.numberStyle = .currency
                                
                                let formattedPrice = formatter.string(from: NSNumber(value:price))
                                
                                self.price.text = formattedPrice
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                    
                else{
                    
                    print("Error: did not connect to the site.")
                    
                }
                
                }.resume()
            
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        
    {
        
        
        
        getCurrencyPrice(cryptoCurrency: cryptoCurrency[picker.selectedRow(inComponent: 0)], currency: currency[picker.selectedRow(inComponent: 1)])
        
        
        
    }
    
    
    

}

