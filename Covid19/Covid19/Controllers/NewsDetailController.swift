//
//  NewsDetailController.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 29/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import WebKit

class NewsDetailController: UIViewController, WKNavigationDelegate {
    var currentItem : NewsEntry?
    var urlString = "https://www.google.com/"
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.webView.navigationDelegate = self
        if let currentItem = currentItem {
            if let link = currentItem.link {
                urlString = link
            }
        }
        if let url = URL(string: urlString) {
            let webRequest  = URLRequest(url: url)
            webView.load(webRequest)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
