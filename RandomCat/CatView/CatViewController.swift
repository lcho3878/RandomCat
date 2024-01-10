//
//  CatViewController.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class CatViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let catImageView = UIImageView()
    
    private let previousButton = UIButton().then {
        $0.setTitle("이전", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(catImageView)
    }
    
    private func setupConstraint() {
        previousButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(20)
        }
        
        catImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
            $0.bottom.equalTo(previousButton.snp.top).offset(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setAddTarget()
        getNextImage()
    }
    
    private func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
    }
    
    @objc func nextButtonClick() {
        getNextImage()
    }
    
    
    private func getNextImage() {
        
        CatManager.shared.getCatURL()
            .subscribe{ event in
                switch event {
                case .next(let url):
                    if let url = url {
                        CatManager.shared.getCatImage(url)
                            .subscribe(onNext: { image in
                                DispatchQueue.main.async {
                                    self.catImageView.image = image
                                }
                            })
                    }
                    
                case .completed:
                    break
                case .error(let error):
                    print(error)
                    break
                }
            }
            .disposed(by: self.disposeBag)
    }
    
}
