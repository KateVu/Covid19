//
//  NewsFeedParser.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 28/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit

class NewsFeedParser: NSObject {
    var parser: XMLParser!
    var status: ParseStatus = .stopped
    var currentPath: URL = URL(string: "/")!
    
    var entries: [NewsEntry]?
    
    
    init?(withUrl url: URL) {
        super.init()
        
        guard let parser = XMLParser(contentsOf: url) else {
            return nil
        }
        
        self.parser = parser
        self.parser.delegate = self
    }
    
    func parse() -> [NewsEntry]? {
        status = .parsing
        
        let success = parser.parse()
        
        if success {
            return self.entries
        } else {
            return nil
        }
    }
    
    func parseAsync(queue: DispatchQueue = DispatchQueue.global(qos: .background), complete: @escaping ([NewsEntry]?) -> Void) {
        queue.async {
            complete(self.parse())
        }
    }
    
    func abort() {
        if status == .parsing {
            parser.abortParsing()
        }
        
        status = .aborted
    }
}

// XMP Parser

extension NewsFeedParser: XMLParserDelegate {
    
    func mapAttributes(_ attributes: [String : String], forPath path: FeedPath) {
        switch (path) {
            
        case .Feed:
            if self.entries == nil {
                self.entries = []
            }
            
        case .FeedEntry:
            self.entries?.append(NewsEntry())
            
        case .FeedEntryLink:
            self.entries?.last?.link = attributes["href"] ?? ""
            
            
        default:
            break
        }
    }
    
    func mapCharacters(_ string: String, forPath path: FeedPath) {
        switch (path) {
            
        case .FeedEntryTitle:
            self.entries?.last?.title = self.entries?.last?.title?.appending(string) ?? string
            
        case .FeedEntryContent:
            self.entries?.last?.content = self.entries?.last?.content?.appending(string) ?? string
            
        case .FeedEntryLink:
            self.entries?.last?.link = self.entries?.last?.link?.appending(string) ?? string
            
        case .FeedEntryPublished:
            self.entries?.last?.published = string.toDate()
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentPath.appendPathComponent(elementName)
        
        if let path = FeedPath(rawValue: currentPath.absoluteString) {
            mapAttributes(attributeDict, forPath: path)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let path = FeedPath(rawValue: currentPath.absoluteString) {
            mapCharacters(string, forPath: path)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentPath.deleteLastPathComponent()
    }
}

extension String {
    func toDate() -> Date? {
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ssZ"
        ]
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: self) {
                return date
            }
        }
        
        return nil
    }
}
