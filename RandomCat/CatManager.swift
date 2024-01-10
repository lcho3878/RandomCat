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
    
    func getCatURL () -> Observable<String?> {
        return Observable.create() { emitter in
            let imageURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
            let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let data = data {
                    do {
                        let catInfos = try JSONDecoder().decode([CatInfo].self, from: data)
                        if let firstCat = catInfos.first {
                            emitter.onNext(firstCat.url)
                        }
                    }
                    catch {
                        emitter.onError(error)
                    }
                }
                
                emitter.onCompleted()
            }
            
            dataTask.resume()
            
            return Disposables.create() {
                dataTask.cancel()
            }
        }
    }
    
    func getCatImage(_ url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let imageURL = URL(string: url)!
            let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                guard error == nil else {
                    emitter.onError(error!)
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
