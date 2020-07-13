//
//  AppData.swift
//  
//
//  Created by Kate Vu (Quyen) on 20/4/20.
//

import Foundation

protocol StatisDataDelegate {
    func dataChanged()
}

class StatisData: QueryServicesDelegate {
    
    var queryService : QueryServices
    var data = [CountryStat]()
    var allData = [CountryStat]()
    var total = CountryStat()
    
    var delegate : StatisDataDelegate?
    
    init() {
        self.queryService = QueryServices();
        
        // set delegate
        queryService.delegate = self
    }
    
    func dataReceived(_ data: [CountryStat]) {
        self.data = data
    }
    
    func dataReveive(_ data: [CountryStat]) {
        self.data = data
        
        if (self.data[0].name == "World") {
            self.total = self.data[0]
            self.data.removeFirst()
        }
        
        self.allData = self.data
        
        DispatchQueue.main.async {
            if let delegate = self.delegate {
                delegate.dataChanged()
            }
        }
    }
    
    func getCount() -> Int {
        return self.data.count
    }
    
    func getItem(_ index: Int) ->  CountryStat{
        return data[index]
    }
    
    func getItemByName(_ name: String) -> CountryStat{
        let result = data.filter{ $0.name == name }
        if !(result.isEmpty) {
            return result[0]
        }
        return CountryStat()
    }
    
    func getData() {
        queryService.getResult()
    }
    
    func handSearchBar(_ text: String)  {
        if (!text.isEmpty) {
            self.data = self.allData.filter { $0.name.lowercased().contains(text.lowercased()) }
        } else {
            self.data = self.allData
        }
        
        DispatchQueue.main.async {
            if let delegate = self.delegate {
                delegate.dataChanged()
            }
        }
    }
}
