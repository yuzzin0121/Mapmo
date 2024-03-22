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
    var showCreateRecordDelegate: ShowCreateRecordDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        mapRecordListViewModel.inputRecordList.bind { recordList in
            self.mainView.collectionView.reloadData()
            self.setEmptyUI(recordList.isEmpty)
        }
    }
    
    private func setEmptyUI(_ isEmpty: Bool) {
        mainView.emptyMessaageLabel.isHidden = !isEmpty
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width, height: 95)
        layout.minimumLineSpacing = 14
        mainView.collectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func loadView() {
        view = mainView
    }
    
    @objc private func addRecordButtonClicked(sender: UIButton) {
        showCreateRecordDelegate?.showCreateRecordVC()
    }
    
    @objc private func heartButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        mapRecordListViewModel.toggleIsFavorite.value = index
        mainView.collectionView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("RecordUpdated"), object: nil, userInfo: nil)
    }
    
}

extension MapRecordListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecordCollectionReusableView.identifier, for: indexPath) as? RecordCollectionReusableView else {
            return UICollectionReusableView()
        }
        headerview.setData(count: mapRecordListViewModel.inputRecordList.value.count)
        headerview.addRecordButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
             
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapRecordListViewModel.inputRecordList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = mapRecordListViewModel.inputRecordList.value[indexPath.item]
        cell.configureCell(record: data)
        cell.heartButton.tag = indexPath.item
        cell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = mapRecordListViewModel.inputRecordList.value[indexPath.item]
        passDelegate?.showDetailRecordVC(recordItem: data)
    }
}


