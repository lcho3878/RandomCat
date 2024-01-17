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
    
    private let catViewModel = CatViewModel()
    
    private let catImageView = UIImageView()
    
    private let previousButton = UIButton().then {
        $0.setTitle("이전", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let myLabel = UILabel()
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemPink
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(catImageView)
        view.addSubview(myLabel)
        view.addSubview(loadingIndicator)
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
        
        myLabel.snp.makeConstraints { make in
            make.top.equalTo(previousButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalTo(catImageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        dataBind()
        setInitialData()
    }
    
    private func dataBind() {
        let input = CatViewModel.Input(
            nextButtonClick: nextButton.rx.tap,
            previousButtonClick: previousButton.rx.tap
        )
        let output = catViewModel.transform(input: input)

        output.isLoading
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.catImage
            .drive(catImageView.rx.image)
            .disposed(by: disposeBag)
        
    }
    
    private func setInitialData() {
        nextButton.sendActions(for: .touchUpInside)
    }
    
}
