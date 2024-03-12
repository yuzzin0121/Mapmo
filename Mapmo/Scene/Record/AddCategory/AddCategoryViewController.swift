//
//  AddCategoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

final class AddCategoryViewController: BaseViewController {
    let mainView = AddCategoryView()

    let addCategoryViewModel = AddCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegateAndAction()
        addCategoryViewModel.colorList.bind { _ in
            self.mainView.colorCollectionView.reloadData()
        }
        addCategoryViewModel.outputWarningMessage.bind { message in
            self.mainView.warningMessageLabel.text = message
        }
    }
    
    deinit {
        print("AddCategoryViewController Deinit")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 32
        let width = mainView.frame.width - (spacing * 2) - (20 * 4) - 32
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        mainView.colorCollectionView.collectionViewLayout = layout
    }
    
    private func setDelegateAndAction() {
        mainView.colorCollectionView.delegate = self
        mainView.colorCollectionView.dataSource = self
        mainView.categoryNameTextField.addTarget(self, action: #selector(categoryNameTextFieldValueChanged), for: .editingChanged)
    }
    
    @objc private func categoryNameTextFieldValueChanged(_ sender: UITextField) {
        print(#function)
        let text = sender.text
        addCategoryViewModel.inputCategoryName.value = text
    }

    override func configureNavigationItem() {
        navigationItem.title = "새 카테고리 추가"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = .customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {  // 뒤로가기 버튼 클릭 시
        navigationController?.popViewController(animated: true)
    }
}


// 색상 컬렉션뷰 설정
extension AddCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addCategoryViewModel.colorList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryColorCollectionViewCell.identifier, for: indexPath) as? SelectCategoryColorCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = addCategoryViewModel.colorList.value[indexPath.item]
        cell.contentView.backgroundColor = UIColor(named: data.name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = addCategoryViewModel.colorList.value[indexPath.item]
        addCategoryViewModel.selectedColor.value = data
    }
}
