//
//  DataManager.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/22.
//

import Foundation
import RxSwift
import UIKit

class DataManager {
    
    static let shared = DataManager()
    var urlList = [String]()
    
    func saveURL(_ url: String) {
        guard !urlList.contains(url) else {return}
        urlList.append(url)
    }
    
    func printURL() {
        print(urlList)
    }
}
