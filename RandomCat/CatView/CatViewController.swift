//
//  CatViewController.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import UIKit
import Then
import SnapKit
import RxCocoa

class CatViewController: UIViewController {
    
    private let myLabel = UILabel().then {
        $0.text = "로딩중"
        $0.textColor = .black
    }

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
        view.addSubview(myLabel)
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
        
        myLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(previousButton.snp.top).offset(-100)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setAddTarget()
        getNextURL()
    }
    
    private func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
    }
    
    @objc func nextButtonClick() {
        getNextURL()
    }
    
    private func getNextURL() {
        let observable = CatManager.shared.getCatURL()
            .subscribe { event in
                switch event {
                case .next(let url):
                    DispatchQueue.main.async {
                        self.myLabel.text = url
                    }
                case .error(let error):
                    print(error)
                case .completed:
                    break
                }
            }
    }

}
