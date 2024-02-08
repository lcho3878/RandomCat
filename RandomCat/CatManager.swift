//
//  CatManager.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import Foundation
import RxSwift
import UIKit
import Kingfisher
 
//"https://api.thecatapi.com/v1/images/search" // TheCatAPI url

class CatManager: Imagemakable, URLmakable {    // imagemakable 프로토콜 채택 고려(의존성 주입)

    func getCatURL (completion: @escaping ((String?, Error?) -> Void)) { // rx사용, 통일성을 위해서
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
    
    func getCatImage(_ url: String) -> Observable<UIImage?> { // UI랑 관련있는건 사용자의 액션과 관련
        return Observable.create { emitter in
            let imageURL = URL(string: url)!
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                KingfisherManager.shared.retrieveImage(with: imageURL) { result in
                    switch result {
                    case .success(let value):
                        emitter.onNext(value.image)
                    case .failure:
                        emitter.onNext(nil)
                    }

                    emitter.onCompleted()
                }
            }


            return Disposables.create()
        }
    }
}
