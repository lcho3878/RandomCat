//
//  CatManager.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import Foundation
import RxSwift
import UIKit
 
//"https://api.thecatapi.com/v1/images/search" // TheCatAPI url

class CatManager {
    
    static let shared = CatManager()
    
    var urlList: [String] = []
    
    
    func getCatURL (completion: @escaping ((String?, Error?) -> Void)) {
        let apiURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
        let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, _, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            
            if let data = data {
                do {
                    let catInfos = try JSONDecoder().decode([CatInfo].self, from: data)
                    if let firstCat = catInfos.first {
                        completion(firstCat.url, nil)
                        return
                    }
                }
                catch {
                    completion(nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
    func getCatImage(_ url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let imageURL = URL(string: url)!
            let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                guard error == nil else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }

                if let data = data {
                    let image = UIImage(data: data)
                    emitter.onNext(image)
                }

                emitter.onCompleted()
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
}
