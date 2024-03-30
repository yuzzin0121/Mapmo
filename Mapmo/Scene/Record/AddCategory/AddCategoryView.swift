//
//  AddCategoryView.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit
import SnapKit

final class AddCategoryView: BaseView {
    let newCategoryNameLabel = UILabel()
    let categoryNameTextField = CustomTextField()
    let warningMessageLabel = UILabel()
    let selectColorLabel = UILabel()
    let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    let addButton = MapmoButton()
    
    // MARK: - Configure
    override func configureHierarchy() {
        [newCategoryNameLabel, categoryNameTextField, warningMessageLabel, selectColorLabel,  colorCollectionView, addButton].forEach {
            addSubview($0)
        }
    }
    override func configureLayout() {
        newCategoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        categoryNameTextField.snp.makeConstraints { make in
            make.top.equalTo(newCategoryNameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(54)
        }
        warningMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryNameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(categoryNameTextField)
            make.height.equalTo(14)
        }
        
        selectColorLabel.snp.makeConstraints { make in
            make.top.equalTo(warningMessageLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectColorLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(addButton.snp.top).offset(-24)
        }
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
    
    override func configureView() {
        newCategoryNameLabel.design(text: "새 카테고리 이름", font: .pretendard(size: 20, weight: .regular))
        categoryNameTextField.placeholder = "새 카테고리 이름을 입력해주세요"
        warningMessageLabel.design(textColor: ColorStyle.markRed)
        
        selectColorLabel.design(text: "색상 선택", font: .pretendard(size: 20, weight: .regular))
        
        colorCollectionView.backgroundColor = ColorStyle.customBackgroundGray
        colorCollectionView.contentInset = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        colorCollectionView.layer.cornerRadius = 12
        colorCollectionView.clipsToBounds = true
        colorCollectionView.register(SelectCategoryColorCollectionViewCell.self, forCellWithReuseIdentifier: SelectCategoryColorCollectionViewCell.identifier)
        
        addButton.setTitle("추가", for: .normal)
    }

}
