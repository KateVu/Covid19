//
//  Country Struct.swift
//
//
//  Created by Kate Vu (Quyen) on 20/4/20.
//

import Foundation

struct CountryStat : Decodable {
    var name: String
    var totalCases: Int?
    var totalDeaths: Int?
    var totalRecovered: Int?
    var seriousCases: Int?
    var population: Int?
    var symbol: String?
    var cities: [City]?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case totalCases
        case totalDeaths
        case totalRecovered
        case seriousCases
        case population
        case symbol
        case cities
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        totalCases = (try? container.decode(Int.self, forKey: .totalCases)) ?? 0
        totalDeaths = (try? container.decode(Int.self, forKey: .totalDeaths)) ?? 0
        totalRecovered = (try? container.decode(Int.self, forKey: .totalRecovered)) ?? 0
        seriousCases = (try? container.decode(Int.self, forKey: .seriousCases)) ?? 0
        population = (try? container.decode(Int.self, forKey: .population)) ?? 0
        symbol = (try? container.decode(String.self, forKey: .symbol)) ?? ""
        cities = (try? container.decode([City].self, forKey: .cities)) ?? [City]()
    }
    
    init() {
        self.name = ""
        self.totalCases = 0
        self.totalDeaths = 0
        self.totalRecovered = 0
        self.seriousCases = 0
        self.population = 0
        self.symbol = ""
        self.cities = [City]()
    }
}

struct City: Codable {
    var name: String?
    var totalCases: Int?
    var totalDeaths: Int?

    init() {
        self.name = ""
        self.totalCases = 0
        self.totalDeaths = 0
    }
}

