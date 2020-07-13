//
//  NewsDetailController.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 29/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit

class InfoDetailController: UIViewController {
    var currentItem : VirusInfor?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentItem = currentItem {
            textView.text = currentItem.content
        }
}
}
