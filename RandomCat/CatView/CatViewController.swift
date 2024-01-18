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
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let loadingIndicator = UIActivityIndicatorView().then {
        $0.color = .systemPink
        $0.hidesWhenStopped = true
        
        let screenSize = UIScreen.main.bounds.size
        let minSize = min(screenSize.width, screenSize.height)
        $0.transform = CGAffineTransform(scaleX: minSize / 200, y: minSize / 200)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(catImageView)
        view.addSubview(saveButton)
        view.addSubview(loadingIndicator)
    }
    
    private func setupConstraint() {
        catImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(view.bounds.width)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        previousButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-20)
            $0.top.equalTo(catImageView.snp.bottom).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(20)
            $0.centerY.equalTo(previousButton)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(previousButton.snp.bottom).offset(20)
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
        setAddtarget()
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
    
    private func setAddtarget() {
        saveButton.addTarget(self, action: #selector(clickSaveButton), for: .touchUpInside)
    }
    
    @objc func clickSaveButton() {
        print("dd")
    }
    
}
