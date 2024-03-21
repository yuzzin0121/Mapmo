//
//  MapRecordListViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit

class MapRecordListViewController: BaseViewController {
    let mainView = MapRecordListView()
    
    let mapRecordListViewModel = MapRecordListViewModel()
    var passDelegate: PassDataAndShowVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        mapRecordListViewModel.inputRecordList.bind { recordList in
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width, height: 90)
        layout.minimumInteritemSpacing = 20
        mainView.collectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func loadView() {
        view = mainView
    }
    
}

extension MapRecordListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapRecordListViewModel.inputRecordList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = mapRecordListViewModel.inputRecordList.value[indexPath.item]
        cell.configureCell(record: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = mapRecordListViewModel.inputRecordList.value[indexPath.item]
        passDelegate?.showDetailRecordVC(recordItem: data)
    }
}


