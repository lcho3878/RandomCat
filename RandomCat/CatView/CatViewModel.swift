//
//  CatViewModel.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/11.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
    
}

final class CatViewModel: ViewModelType {
    
    private let catManager = CatManager()
    private var urlList: [String] = []
    private var index: Int = 0
    private let newCatURLSubject = PublishSubject<String>()
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    
    var disposeBag: DisposeBag
    
    struct Input {
        let nextButtonClick: ControlEvent<Void>
        let previousButtonClick: ControlEvent<Void>
    }
    
    struct Output {
        let catImage: Driver<UIImage?>
        let isLoading: Driver<Bool>
    }
    
    init() {
        disposeBag = DisposeBag()
        
    }
    
    func transform(input: Input) -> Output {
        let nextIndex = input.nextButtonClick
            .map {
                self.index += 1
                return self.index
            }
            .asDriver(onErrorJustReturn: 0)
        
        let previoudIndex = input.previousButtonClick
            .map {
                self.index -= self.index - 1 >= 0 ? 1 : 0
                return self.index
            }
            .asDriver(onErrorJustReturn: 0)
        
        let catURL = Driver.merge(nextIndex, previoudIndex)
            .flatMapLatest { [weak self] index -> Driver<String> in
                guard let self = self else { return Driver.just("") }
                if index >= 0 && index < self.urlList.count {
                    return Driver.just(self.urlList[index])
                } else {
                    self.fetchNewCatURL()
                    return self.newCatURLSubject.asDriver(onErrorJustReturn: "")
                }
            }
        
        let catImage = catURL
            .flatMapLatest { [weak self] url -> Driver<UIImage?> in
                guard let self = self else { return Driver.just(nil) }
                self.isLoadingSubject.onNext(true)
                return self.catManager.getCatImage(url)
                    .do(onNext: { _ in
                        self.isLoadingSubject.onNext(false)
                    })
                    .asDriver(onErrorJustReturn: nil)
            }
        
        catURL.drive().disposed(by: disposeBag)
        catImage.drive().disposed(by: disposeBag)
        
        return Output(catImage: catImage, isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false))
    }
    
    private func fetchNewCatURL() {
        catManager.getCatURL { [weak self] (url, err) in
            guard err == nil, let url = url else {
                return
            }
            
            self?.urlList.append(url)
            self?.newCatURLSubject.onNext(url)
        }
    }
}
