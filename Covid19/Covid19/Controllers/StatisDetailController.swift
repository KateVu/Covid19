//
//  StatisDetailController.swift
//  PersistentData
//
//  Created by Kate Vu (Quyen) on 16/4/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit

class StatisDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource,StatisDataDetailDelegate {
    
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var confirmed: UILabel!
    @IBOutlet weak var recovered: UILabel!
    @IBOutlet weak var deceased: UILabel!
    @IBOutlet weak var serious: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var currentItem: CountryStat?
    var appDataQuery = StatisDataDetail()
    var currentData = [CountryStat]()
    var displayData = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        appDataQuery.delegate = self

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        if let currentItem = currentItem {
            region.text = currentItem.name
            if let populationText = currentItem.population {
                if (populationText == 0) {
                    population.text = ""
                } else {
                    population.text = "Population: " + populationText.formatNumber()
                }
            }
            if let totalCases = currentItem.totalCases {
                confirmed.text = totalCases.formatNumber()
            }
            if let totalDeaths = currentItem.totalDeaths {
                deceased.text = totalDeaths.formatNumber()
            }
            if let totalRecovered = currentItem.totalRecovered {
                recovered.text = totalRecovered.formatNumber()
            }
            if let seriousCases = currentItem.seriousCases {
                serious.text = seriousCases.formatNumber()
            }
            if let country_code = currentItem.symbol {
                let urlString = "https://www.countryflags.io/" + country_code + "/flat/64.png"
                let url = URL(string: urlString)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    flag.image = UIImage(data: imageData)
                }
            }
        }
        var query = "latest"
        if let currentItem = currentItem {
            query = currentItem.name.lowercased()
        }
        appDataQuery.queryServiceDetail.setQuery(query)
        appDataQuery.getData()
    }
    
    func dataChangedForDetail() {
        self.indicator.stopAnimating()
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.appDataQuery.getCount()
        // return appData.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath)
        
        // Configure the cell...
        let item = appDataQuery.getItem(indexPath.row)
        let regionName = cell.contentView.viewWithTag(201) as! UILabel
        regionName.text = item.name
        if let totalCases = item.totalCases {
            let confirmed = cell.contentView.viewWithTag(202) as! UILabel
            confirmed.text = totalCases.formatNumber()
        }
        if let totalDeaths = item.totalDeaths {
            let deceased = cell.contentView.viewWithTag(203) as! UILabel
            deceased.text = totalDeaths.formatNumber()
        }
        return cell
    }

    
}

