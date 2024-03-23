//
//  RecordListViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

final class RecordListViewController: BaseViewController {
    let mainView = RecordListView()
    
    let recordListViewModel = RecordListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        recordListViewModel.outputRecordItemList.bind { recordItemList in
            self.mainView.collectionView.reloadData()
            self.setEmptyUI(recordItemList.isEmpty)
        }
    }
    
    private func setEmptyUI(_ isEmpty: Bool) {
        mainView.emptyMessaageLabel.isHidden = !isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordListViewModel.fetchFavoriteRecordsTrigger.value = ()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (mainView.frame.width - 32 - 14) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 180)
        layout.minimumInteritemSpacing = 14
        mainView.collectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func configureNavigationItem() {
        navigationItem.title = TabItem.list.title
    }
    
    override func loadView() {
        view = mainView
    }
    
    @objc private func heartButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        recordListViewModel.toggleIsFavorite.value = index
        NotificationCenter.default.post(name: NSNotification.Name("RecordUpdated"), object: nil, userInfo: nil)
    }
    
    private func showDetailRecordVC(recordItem: RecordItem) {
        let detailRecordVC = DetailRecordViewController()
        detailRecordVC.detailRecordViewModel.inputRecordItem.value = recordItem
        detailRecordVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailRecordVC, animated: true)
    }
}

extension RecordListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecordListCollectionReusableView.identifier, for: indexPath) as? RecordListCollectionReusableView else {
                return UICollectionReusableView()
            }
            headerView.setData(count: recordListViewModel.outputRecordItemList.value.count)
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordListViewModel.outputRecordItemList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordListCollectionViewCell.identifier, for: indexPath) as? RecordListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = recordListViewModel.outputRecordItemList.value[indexPath.item]
        cell.configureCell(record: data)
        cell.recordCardView.heartButton.tag = indexPath.item
        cell.recordCardView.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = recordListViewModel.outputRecordItemList.value[indexPath.item]
        showDetailRecordVC(recordItem: data)
    }
}
