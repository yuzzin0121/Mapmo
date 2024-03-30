//
//  SelectCategoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

final class SelectCategoryViewController: BaseViewController {
    let mainView = SelectCategoryView()

    let selectCategoryViewModel = SelectCategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        selectCategoryViewModel.fetchCategoryTrigger.value = ()
        selectCategoryViewModel.categoryList.bind { _ in
            self.mainView.collectionView.reloadData()
        }
    }
    
    @objc private func nextButtonClicked(sender: UIButton) {
        let createRecordVC = CreateRecordViewController()
        // TODO: - 카테고리 값 전달 필요
        guard let selectedCategory = selectCategoryViewModel.inputSelectedCategory.value else { return }
        createRecordVC.createRecordViewModel.inputSelectedCategory.value = selectedCategory
        createRecordVC.createRecordViewModel.previousVC = .selectCatgory
        navigationController?.pushViewController(createRecordVC, animated: true)
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
//    private func setSwipe() {
//        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
//        swipeRecognizer.direction = .right
//        view.addGestureRecognizer(swipeRecognizer)
//    }
    
//    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
//        if sender.direction == .right {
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width - 32, height: 60)
        layout.minimumInteritemSpacing = 16
        mainView.collectionView.collectionViewLayout = layout
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
    
    @objc private func addCategoryButtonClicked(sender: UIButton) {
        let addCategoryVC = AddCategoryViewController()
        addCategoryVC.completionHandler = { // 새 카테고리가 추가됐을 때 : 카테고리 리스트 갱신
            self.selectCategoryViewModel.fetchCategoryTrigger.value = ()
        }
        navigationController?.pushViewController(addCategoryVC, animated: true)
    }
}

extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 헤더 적용
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일 때
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SelectCategoryCollectionHeaderView.identifier,
                for: indexPath) as? SelectCategoryCollectionHeaderView else {
            return UICollectionReusableView()
        }
        headerView.addCategoryButton.addTarget(self, action: #selector(addCategoryButtonClicked), for: .touchUpInside)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 80)
    }
    
    // 카테고리 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectCategoryViewModel.categoryList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCollectionViewCell.identifier, for: indexPath) as? SelectCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = selectCategoryViewModel.categoryList.value[indexPath.item]
        
        cell.configureCell(category: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        mainView.nextButton.isEnabled = true
        mainView.nextButton.backgroundColor = ColorStyle.mapmoColor
        
        let data = selectCategoryViewModel.categoryList.value[indexPath.item]
        selectCategoryViewModel.inputSelectedCategory.value = data
    }
}
