//
//  NewsEntry.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 28/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit

class NewsEntry {
    var title: String?
    var link: String?
    var published: Date?
    var content: String?
    
    init() {
        self.title = ""
        self.link = ""
        self.content = ""
    }
}
