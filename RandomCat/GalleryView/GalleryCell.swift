//
//  GalleryCell.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class GalleryCell: UICollectionViewCell {
    private var disposeBag: DisposeBag?
    
    private let catmanager = CatManager()
    
    private let catImageView = UIImageView()

    private let loadingIndicator = UIActivityIndicatorView().then {
        $0.color = .systemPink
        $0.hidesWhenStopped = true
//
//        let screenSize = UIScreen.main.bounds.size
//        let minSize = min(screenSize.width, screenSize.height)
//        $0.transform = CGAffineTransform(scaleX: minSize / 200, y: minSize / 200)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
        catImageView.image = nil
        loadingIndicator.startAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        addSubview(catImageView)
        addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    private func setupConstraint() {
        catImageView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureUI (_ url: String) {
        disposeBag = DisposeBag()
        
        let image = catmanager.getCatImage(url)
            .bind(onNext: { [weak self] image in
                if let image = image {
                    print("이미지를 로드합니다")
                    self?.catImageView.image = image
                    self?.loadingIndicator.stopAnimating()
                }
            })
    }
}
