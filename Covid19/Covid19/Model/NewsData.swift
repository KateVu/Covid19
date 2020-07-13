//
//  NewsData.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 28/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
protocol NewsDataDelegate {
    func dataLoaded()
}
class NewsData: NSObject {
    
    var newsList: [NewsEntry]?
    var delegate : NewsDataDelegate?
    let fileURL = URL(string: "https://www.google.com/alerts/feeds/17264153694416747200/3137147317882805514")!
    
    func fetchNews() {
        if let parser = NewsFeedParser(withUrl: fileURL) {
            parser.parseAsync() { entries in
                if let entries = entries {
                    for entry in entries {
                        entry.title = entry.title?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                        entry.content = entry.content?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                    }
                    self.newsList = entries
                }
                DispatchQueue.main.async {
                    if let delegate = self.delegate {
                        delegate.dataLoaded()
                    }
                }
            }
        }
    }
}

