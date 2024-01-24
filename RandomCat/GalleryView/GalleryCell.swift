//
//  GalleryCell.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/23.
//

import UIKit
import SnapKit
import Then

class GalleryCell: UICollectionViewCell {
    private let customLabel = UILabel().then {
        $0.text = "dfalkjsdflkajdlkfjalksdfjlkadsjflkasdf"
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
        addSubview(customLabel)
    }
    
    private func setupConstraint() {
        customLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }
    
    func configureUI (_ url: String) {
        customLabel.text = url
    }
}
