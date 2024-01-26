//
//  GalleryViewController.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/22.
//

import UIKit
import Then
import SnapKit
import RxSwift

class GalleryViewController: UIViewController {
    private let catManager = CatManager()
    
    private let galleryViewModel = GalleryViewModel()
    
    private let catCollectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 1
        $0.minimumLineSpacing = 1
        let itemWidth = UIScreen.main.bounds.width / 2
        $0.itemSize = CGSize(width: itemWidth - $0.minimumInteritemSpacing / 2, height: itemWidth)
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.width.equalToSuperview()
        }
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.urlList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }
        let image = galleryViewModel.imageList[indexPath.row]
        cell.configureUI(image)
        return cell
    }
}
