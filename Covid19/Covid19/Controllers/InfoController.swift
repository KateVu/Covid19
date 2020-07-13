//
//  AboutVirusViewController.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 5/6/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit
class InfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var virusData = VirusData()
    var currentItem : VirusInfor?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "About This Virus"
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
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
        return virusData.virusInfor.count
        // return appData.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inforCell", for: indexPath)
        let item = virusData.virusInfor[indexPath.row]
        
        // Configure the cell...
        let title = cell.contentView.viewWithTag(501) as! UILabel
        title.text = item.title
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            currentItem = virusData.virusInfor[indexPath.row]
            performSegue(withIdentifier: "showInfoDetail", sender: nil)
        }
    
        // MARK: - Navigation
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if let aboutVirusDetailController = segue.destination as?
                InfoDetailController {
                aboutVirusDetailController.currentItem = currentItem
                aboutVirusDetailController.title = self.currentItem?.title
            }
    
}
}
