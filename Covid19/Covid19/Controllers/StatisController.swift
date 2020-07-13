//
//  ViewController.swift
//  PersistentData
//
//  Created by Kate Vu (Quyen) on 16/4/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import UIKit

class StatisController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    StatisDataDelegate,
    UISearchResultsUpdating,
UISearchBarDelegate {
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalDeceased: UILabel!
    @IBOutlet weak var totalSerious: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet var tableView: UITableView!
    
    var imageCache: [String: UIImage] = [:]
    
    var currentItem : CountryStat?
    var appData = StatisData()
    var currentData = [CountryStat]()
    let queryService = QueryServices()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        appData.delegate = self
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        setUpSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Utility.isInternetAvailable() {
            Utility.topupErrorLayer(overController: self, errorMessage: "No Internet Connection", retryCommand: #selector(self.retryCommand(sender:)))
        } else {
            queryData()
        }
    }
    
    func queryData() {
        let query = "latest"
        appData.queryService.setQuery(query)
        appData.getData()
    }
    
    @objc func retryCommand(sender: Any) {
        if Utility.isInternetAvailable() {
            Utility.removeErrorLayer(onController: self)
            queryData()
        }
    }

    func dataChanged() {
        self.indicator.stopAnimating()
        self.tableView.reloadData()
        let firstItem = appData.total
        if let totalCases = firstItem.totalCases {
            totalConfirmed.text = totalCases.formatNumber()
        }
        if let totalDeaths = firstItem.totalDeaths {
            totalDeceased.text = totalDeaths.formatNumber()
        }
        if let totalRecoveredV = firstItem.totalRecovered {
            totalRecovered.text = totalRecoveredV.formatNumber()
        }
        if let seriousCases = firstItem.seriousCases {
            totalSerious.text = seriousCases.formatNumber()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.searchBar.showsScopeBar = false
        self.searchController.searchBar.placeholder = "Search by country"
        navigationItem.titleView = self.searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            appData.handSearchBar(searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var text = searchController.searchBar.text
        self.searchController.isActive = false
        if let text = text {
            searchController.searchBar.text = text
        }
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
        return appData.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = appData.getItem(indexPath.row)
        
        // Configure the cell...
        let region = cell.contentView.viewWithTag(101) as! UILabel
        region.text = item.name
        
        if let totalCases = item.totalCases {
            let confirmed = cell.contentView.viewWithTag(102) as! UILabel
            confirmed.text = totalCases.formatNumber()
        }
        if let totalDeaths = item.totalDeaths {
            let deceased = cell.contentView.viewWithTag(103) as! UILabel
            deceased.text = totalDeaths.formatNumber()
        }
        
        
        if let country_code = item.symbol {
            let urlString = "https://www.countryflags.io/" + country_code + "/flat/64.png"
            let image = cell.contentView.viewWithTag(100) as! UIImageView
            image.image = nil

            image.fetchImage(urlString: urlString, symbol: item.symbol, view: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem = appData.getItem(indexPath.row)
        performSegue(withIdentifier: "showDetail", sender: nil)
        self.searchController.isActive = false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewDetailController = segue.destination as?
            StatisDetailController {
            viewDetailController.currentItem = currentItem
        }
        
    }
}

extension UIImageView {
    func fetchImage(urlString: String, symbol: String?, view: StatisController?) {
        if let symbol = symbol {
            if view?.imageCache[symbol] != nil {
                self.image = view?.imageCache[symbol]
                return
            }
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                    view?.imageCache[symbol] = image
                })
            }).resume()
        }
    }
}

extension Int {
    func formatNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self)) ?? "0"
    }
}
