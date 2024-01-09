//
//  ViewController.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import UIKit
import Then
import SnapKit

class MainViewController: UIViewController {
    
    private let randomButton = UIButton().then {
        $0.setTitle("랜덤 고양이 사진 보러가기", for: .normal)
        $0.backgroundColor = .systemPink
        
    }
    
    private let galleryButton = UIButton().then {
        $0.setTitle("저장된 사진 보러가기", for: .normal)
        $0.backgroundColor = .systemPink
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setAddTarget()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(randomButton)
        view.addSubview(galleryButton)
    }
    
    private func setupConstraint() {
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(10)
        }
        
        galleryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
        }
    }
    
    @objc func clickRandomButton() {
        let catVC = CatViewController()
        self.navigationController?.pushViewController(catVC, animated: true)
    }
    
    @objc func clickGalleryButton() {
        print("갤러리 클릭")
    }
    
    private func setAddTarget() {
        randomButton.addTarget(self, action: #selector(clickRandomButton), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(clickGalleryButton), for: .touchUpInside)
        
    }


}

