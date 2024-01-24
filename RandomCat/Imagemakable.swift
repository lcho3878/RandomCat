//
//  Imagemakable.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/22.
//

import Foundation
import RxSwift
import UIKit

protocol Imagemakable {
    func getCatImage(_ url: String) -> Observable<UIImage?>
}

protocol URLmakable {
    func getCatURL(completion: @escaping ((String?, Error?) -> Void))
}
