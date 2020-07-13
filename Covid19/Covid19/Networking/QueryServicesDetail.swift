//
//  QueryServices.swift
//  PersistentData
//
//  Created by Kate Vu (Quyen) on 19/4/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation

protocol QueryServicesDetailDelegate {
    func dataReveivedDetail(_ data: CountryStat)
}

class QueryServicesDetail {
    
    let BASE_URL = "https://exchange.vcoud.com/coronavirus/"
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask : URLSessionTask?
    var query = "latest"
    var errorMessage = ""
    
    var delegate : QueryServicesDetailDelegate?
    
    func setQuery(_ query: String) {
        self.query = query
    }
    
    public func getResult()  {
        dataTask?.cancel()
        let baseURL = BASE_URL + query
        if var urlComponents = URLComponents(string: baseURL) {
            urlComponents.query = "" //"$$app_token=\(APP_TOKEN)&&$limit=\(limit)"
            
            guard let url = urlComponents.url else {
                return
            }

            dataTask = defaultSession.dataTask(with: url) {
                [weak self] resultData, response, error in defer { self?.dataTask = nil}
                
                if let error = error {
                    self?.errorMessage += "DataTask error: " +
                        error.localizedDescription + "\n"
                } else if let resultData = resultData,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(CountryStat.self, from: resultData)
                        if let delegate = self?.delegate {
                            delegate.dataReveivedDetail(data)
                        }
                    } catch let parseError as NSError {
                        print("Codable error: \(parseError.localizedDescription)\n")
                        return
                    }
                    DispatchQueue.main.async {}
                }
                
            }
            dataTask?.resume()
        }
    }

}
