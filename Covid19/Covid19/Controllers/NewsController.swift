//
//  NewsController.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 28/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewsDataDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var newsData = NewsData()
    var currentItem : NewsEntry?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Covid-19 News"
        
        newsData.delegate = self
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.indicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !Utility.isInternetAvailable() {
            Utility.topupErrorLayer(overController: self, errorMessage: "No Internet Connection", retryCommand: #selector(self.retryCommand(sender:)))
        } else {
            let newsCount = self.newsData.newsList?.count ?? 0
            if newsCount == 0 {
                newsData.fetchNews()
            }
        }
    }
    
    @objc func retryCommand(sender: Any) {
        if Utility.isInternetAvailable() {
            Utility.removeErrorLayer(onController: self)
            queryData()
        }
    }
    
    
    func queryData() {
        self.indicator.startAnimating()
        newsData.fetchNews()
    }
    
    func dataLoaded() {
        self.indicator.stopAnimating()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsData.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        
        // Configure the cell...
        if let data = self.newsData.newsList{
            let item = data[indexPath.row]
            let title = cell.contentView.viewWithTag(301) as! UILabel
            title.text = item.title
            
            let content = cell.contentView.viewWithTag(302) as! UILabel
            content.text = item.content
            let published = cell.contentView.viewWithTag(303) as! UILabel
            published.text = item.published?.toString(withFormat: "EEE dd MMM yyyy")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.newsData.newsList{
            currentItem = data[indexPath.row]
            performSegue(withIdentifier: "showNews", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newsDetailController = segue.destination as? NewsDetailController {
            newsDetailController.currentItem = currentItem
        }
        
    }
    
}

extension Date {
    func toString(withFormat format: String) -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
