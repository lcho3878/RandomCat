//
//  GalleryViewController.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/22.
//

import UIKit
import Then
import SnapKit

class GalleryViewController: UIViewController {
    
    private let catCollectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var catCollectionView = UICollectionView(frame: .zero, collectionViewLayout: catCollectionViewLayout)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        catCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(catCollectionView)
    }
    
    private func setupConstraint() {
        catCollectionView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.urlList.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }
        let url = DataManager.shared.urlList[indexPath.row]
        cell.configureUI(url)
        return cell
    }
    
    
}
