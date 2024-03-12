//
//  CreateRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class CreateRecordViewController: BaseViewController {
    let mainView = CreateRecordView()
    let createRecordViewModel = CreateRecordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "기록 생성하기"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = .customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return createRecordViewModel.inputRecordSectionList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch indexPath.item {
        case InputRecordSection.photo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCollectionViewCell.identifier, for: indexPath) as? AddPhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case InputRecordSection.place.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputPlaceCollectionViewCell.identifier, for: indexPath) as? InputPlaceCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case InputRecordSection.visitDate.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputVisitedDateCollectionViewCell.identifier, for: indexPath) as? InputVisitedDateCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case InputRecordSection.memo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputMemoCollectionViewCell.identifier, for: indexPath) as? InputMemoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        switch indexPath.item {
        case InputRecordSection.photo.rawValue:
            return CGSize(width: view.frame.width, height: InputRecordSection.photo.cellHeight)
        case InputRecordSection.place.rawValue:
            return CGSize(width: view.frame.width, height: InputRecordSection.place.cellHeight)
        case InputRecordSection.visitDate.rawValue:
            return CGSize(width: view.frame.width, height: InputRecordSection.visitDate.cellHeight)
        case InputRecordSection.memo.rawValue:
            return CGSize(width: view.frame.width, height: InputRecordSection.memo.cellHeight)
        default:
            return CGSize(width: view.frame.width, height: 100)
        }
    }
    
}
