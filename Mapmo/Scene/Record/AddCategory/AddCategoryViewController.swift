//
//  AddCategoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

final class AddCategoryViewController: BaseViewController {
    let mainView = AddCategoryView()
    var completionHandler: (() -> Void)?

    let addCategoryViewModel = AddCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegateAndAction()
        addCategoryViewModel.colorList.bind { [weak self] _ in
            guard let self = self else { return }
            self.mainView.colorCollectionView.reloadData()
        }
        addCategoryViewModel.outputWarningMessage.bind { [weak self] message in
            guard let self = self else { return }
            self.mainView.warningMessageLabel.text = message
        }
        addCategoryViewModel.isActive.bind { [weak self] isActive in
            guard let self = self else { return }
            self.checkIsValid(isActive)
        }
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func checkIsValid(_ isActive: Bool) {
        mainView.addButton.isEnabled = isActive ? true : false
        mainView.addButton.backgroundColor = isActive ? ColorStyle.mapmoColor : ColorStyle.mapmoBackgroundColor
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
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc private func addButtonClicked(_ sender: UIButton) {
        addCategoryViewModel.addButtonClickTrigger.value = ()
        completionHandler?()
        popView()
    }
    
    @objc private func categoryNameTextFieldValueChanged(_ sender: UITextField) {
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
