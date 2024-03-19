//
//  ChartViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/17/24.
//

import UIKit
import SnapKit

class ChartViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case categoryRecordCount
        case recordCount
        case categoryLikeCount
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
    }
    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    private func configureView() {
        collectionView.showsVerticalScrollIndicator = false
    }

}

extension ChartViewController {
    
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .categoryRecordCount:
                return self.createCategoryRecordCountLayout()
            case .recordCount:
                return self.createRecordCountLayout()
            case .categoryLikeCount:
                return self.createCategoryLikeCount()
            }
        }
        
        return layout
    }
    
    private func createCategoryRecordCountLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(162))
        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
    private func createRecordCountLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
    private func createCategoryLikeCount() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
    
    
}


