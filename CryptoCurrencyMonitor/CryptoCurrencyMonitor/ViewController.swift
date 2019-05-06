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
    
    var currencyPrice: Double = 0.0
    var USDPrice: Double = 1.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Crypto-currency and its symbol
        // Bitcoin : BTC
        // Ethereum : ETH
        // Ripple : XRP
        // Bitcoin Cash : BCH
        // Stellar Lumens: XLM
        // EOS: EOS
        // Litecoin: LTC
        // Cardano: ADA
        // Monero: XMR
        // Tron: TRX
        
        
        // Regular Currency and its symbol
        // US Dollar : USD
        // Euro :  EUR
        // Japanese Yen: JPY
        // Great Britain Pound: GBP
        // Swiss Frank : CHF
        // Canadian Dollar: CAD
        // Australian Dollar : AUD
        
        cryptoCurrency = [ "BTC", "ETH", "XRP", "BCH", "XLM", "EOS", "LTC", "ADA", "XMR", "TRX"]
        
        currency = ["USD", "EUR", "JPY", "GBP", "CHF", "CAD", "AUD" ]
        
      
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2  // there are two elements in the PickerView
        
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
                            
                            
                            
                            if let price = json[currency] {
                                
                                self.currencyPrice = price
                                
                                let formatter = NumberFormatter()
                                
                                formatter.currencyCode = currency
                                
                                formatter.numberStyle = .currency
                                
                                let formattedPrice = formatter.string(from: NSNumber(value:price))
                                
                                self.price.text = formattedPrice
                                
                            }
                            // making the currency conversion to USD
                            self.currencyConversion.text = String(format: "%7.3f",self.currencyPrice/self.USDPrice)
                
                            
                        }
                        
                    }
                    
                }
                    
                else{
                    
                    print("Error: did not connect to the site.")
                    
                }
                
                }.resume()
            
        }
        
    }
    
    
    //https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,JPY,EUR
    // get the price in USD to make the conversion
    func getUSDPrice(cryptoCurrency: String){
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=" + cryptoCurrency + "&tsyms=" + "USD"){
            
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                if let data = data {
                    
                    
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String:Double]{
                        
                        DispatchQueue.main.async {  // runs the code in the main thread
                            
                           
                            
                            if let USD_price = json["USD"] {
                                
                               // print ("USD_price ", self.currencyPrice,USD_price)
                                
                                self.USDPrice = USD_price
                                
                              
                                
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
        
        
        // get price in USD
        getUSDPrice(cryptoCurrency: cryptoCurrency[picker.selectedRow(inComponent: 0)])
        
        // Get price in the given currency
        getCurrencyPrice(cryptoCurrency: cryptoCurrency[picker.selectedRow(inComponent: 0)], currency: currency[picker.selectedRow(inComponent: 1)])
        
       
       
        
    }
    
    
    

}

