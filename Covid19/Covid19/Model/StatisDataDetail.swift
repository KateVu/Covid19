
//
//  AppData.swift
//
//
//  Created by Kate Vu (Quyen) on 20/4/20.
//

import Foundation

protocol StatisDataDetailDelegate {
    func dataChangedForDetail()
}

class StatisDataDetail: QueryServicesDetailDelegate {
    
    var queryServiceDetail : QueryServicesDetail
    var data = [City]()
    var allData = [CountryStat]()

    var delegate : StatisDataDetailDelegate?
    
    init() {
        self.queryServiceDetail = QueryServicesDetail();
        
        queryServiceDetail.delegate = self
    }
        
    func dataReveivedDetail(_ data: CountryStat) {
        if let dataValue = data.cities {self.data = dataValue}

        DispatchQueue.main.async {
            if let delegate = self.delegate {
                delegate.dataChangedForDetail()
            }
        }
    }
    
    func getCount() -> Int {
        return self.data.count
    }
    
    func getItem(_ index: Int) ->  City{
        return data[index]
    }
    
    func getItemByName(_ name: String) -> City{
        let result = data.filter{ $0.name == name }
        if !(result.isEmpty) {
            return result[0]
        }
        return City()
    }
    
    func getData() {
        queryServiceDetail.getResult()
    }
    
}
