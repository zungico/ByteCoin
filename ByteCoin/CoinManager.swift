//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Вова on 19.02.2023.
//

import UIKit

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func performRequest (with currency: String) {
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=079C0162-AEEF-424F-BB6E-B44185786DD7"
        
        if let safeURL = URL(string: urlString) {
            
            let session = URLSession (configuration: .default)
            
            let task = session.dataTask(with: safeURL) { (data, responce, error) in
                
                if error != nil {
                    delegate?.didFailWithError(error!)
                    print (error!)
                    
                } else {
                    
                    if let safeData = data {
                        if let rate = parseJSON(safeData) {
                            print(rate)
                            delegate?.didUpdateCurrency(rate, for: currency)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: data)
            let rate = decodedData.rate
            return rate
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

//MARK: - CoinManagerDelegate

protocol CoinManagerDelegate {
    
    func didUpdateCurrency (_ rate: Double, for currency: String)
    
    func didFailWithError (_ error: Error)
}

