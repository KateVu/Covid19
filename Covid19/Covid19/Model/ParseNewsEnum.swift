//
//  ParseNewsEnum.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 28/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation


enum ParseStatus: Int {
    case parsing
    case stopped
    case aborted
    case failed
}

enum FeedPath: String {
    case Feed                           = "/feed"
    case FeedEntry                      = "/feed/entry"
    case FeedEntryTitle                 = "/feed/entry/title"
    case FeedEntryLink                  = "/feed/entry/link"
    case FeedEntryPublished             = "/feed/entry/published"
    case FeedEntryContent               = "/feed/entry/content"
}
