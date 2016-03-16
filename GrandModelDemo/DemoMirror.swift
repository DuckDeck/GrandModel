//
//  DemoMirror.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/12/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

public class Store {
    let storesToDisk: Bool = true
}
public class BookmarkStore: Store {
    let itemCount: Int = 10
}
public struct Bookmark {
    enum Group {
        case Tech
        case News
    }
    private let store = {
        return BookmarkStore()
    }()
    let title: String?
    let url: NSURL
    let keywords: [String]
    let group: Group
}

let aBookmark = Bookmark(title: "Appventure", url: NSURL(string: "appventure.me")!, keywords: ["Swift", "iOS", "OSX"], group: .Tech)
