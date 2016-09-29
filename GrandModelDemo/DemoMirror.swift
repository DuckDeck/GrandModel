//
//  DemoMirror.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/12/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

open class Store {
    let storesToDisk: Bool = true
}
open class BookmarkStore: Store {
    let itemCount: Int = 10
}
public struct Bookmark {
    enum Group {
        case tech
        case news
    }
    fileprivate let store = {
        return BookmarkStore()
    }()
    let title: String?
    let url: URL
    let keywords: [String]
    let group: Group
}

let aBookmark = Bookmark(title: "Appventure", url: URL(string: "appventure.me")!, keywords: ["Swift", "iOS", "OSX"], group: .tech)
