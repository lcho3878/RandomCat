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
    
    private let catImageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
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
    }
    
    private func setupConstraint() {
        catImageView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
    
    func configureUI (_ image: Observable<UIImage?>) {
        disposeBag = DisposeBag()
        
        image
            .bind(onNext: { [weak self] image in
                if let image = image{
                    self?.catImageView.image = image
                }
            })
            .disposed(by: disposeBag!)
    }
}
