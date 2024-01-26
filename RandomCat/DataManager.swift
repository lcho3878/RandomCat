//
//  DataManager.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/22.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    var urlList = [String]()
    
    init(urlList: [String] = [String]()) {
        if let urlList = UserDefaults.standard.object(forKey: "urlList") as? [String] {
            self.urlList = urlList
        }
        else {
            self.urlList = []
        }
    }
    
    func saveURL(_ url: String) {
        guard !urlList.contains(url) else {return}
        urlList.append(url)
        UserDefaults.standard.set(urlList, forKey: "urlList")
    }
    
    func clearURL() {
        UserDefaults.standard.removeObject(forKey: "urlList")
    }
}
