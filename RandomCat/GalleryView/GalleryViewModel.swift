//
//  GalleryViewModel.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/25.
//

import UIKit
import RxSwift

class GalleryViewModel {
    public let disposeBag = DisposeBag()
    
    private let catManager = CatManager()
    
    var imageList = [Observable<UIImage?>]()
    
    init(imageList: [Observable<UIImage?>] = [Observable<UIImage?>]()) {
        self.imageList = DataManager.shared.urlList.map { catManager.getCatImage($0) }
    }

}

