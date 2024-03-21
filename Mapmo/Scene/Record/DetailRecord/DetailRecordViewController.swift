//
//  DetailRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import RealmSwift

final class DetailRecordViewController: BaseViewController {
    let mainView = DetailRecordView()
    
    let detailRecordViewModel = DetailRecordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegateAndAction()
        detailRecordViewModel.inputRecordItem.bind { record in
            guard let record = record else { return }
            self.setData(record)
        }
    }
    
    // 전달받은 기록 데이터 UI에 반영
    private func setData(_ record: RecordItem) {
        setImages(images: record.images)
        mainView.placeInfoView.valueLabel.text = record.place.roadAddress
        mainView.visitDateInfoView.valueLabel.text = DateFormatterManager.shared.formattedVisitedDate(record.visitedAt)
        mainView.memoInfoView.memoTextView.text = record.memo
        
        navigationItem.title = record.place.title
    }
    
    // 이미지 데이터 스크롤뷰에 적용
    private func setImages(images: [UIImage]) {
        mainView.pageControl.numberOfPages = images.count
        mainView.imageScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(images.count), height: 200)
        for index in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[index]
            imageView.contentMode = .scaleAspectFill
            
            imageView.frame = CGRect(x: UIScreen.main.bounds.width * CGFloat(index),
                                     y: 0,
                                     width: UIScreen.main.bounds.width,
                                     height: 200)
            mainView.imageScrollView.addSubview(imageView)
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func setDelegateAndAction() {
        mainView.imageScrollView.delegate = self
        mainView.editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "기록 상세"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = ColorStyle.customBlack
        
        navigationItem.leftBarButtonItem = backButton
    
        let editBarButton = UIBarButtonItem(customView: mainView.editButton)
        let deleteBarButton = UIBarButtonItem(customView: mainView.deleteButton)
        navigationItem.rightBarButtonItems = [deleteBarButton, editBarButton]
    }
    
    // 편집 버튼 클릭 시
    @objc private func editButtonClicked() {
        print(#function)
        let createRecordVC = CreateRecordViewController()
        
        guard let recordItem = detailRecordViewModel.inputRecordItem.value else { return }
        createRecordVC.createRecordViewModel.previousVC = .detailRecord
        createRecordVC.createRecordViewModel.inputSelectedImageList.value = recordItem.images
        createRecordVC.createRecordViewModel.inputPlace.value = recordItem.place
        createRecordVC.createRecordViewModel.inputVisitDate.value = recordItem.visitedAt
        createRecordVC.createRecordViewModel.inputMemo.value = recordItem.memo
        createRecordVC.createRecordViewModel.inputSelectedCategory.value = recordItem.category
        createRecordVC.createRecordViewModel.createdAt = recordItem.createdAt
        createRecordVC.createRecordViewModel.isFavorite = recordItem.isFavorite
        createRecordVC.createRecordViewModel.recordId = recordItem.id
        
        createRecordVC.passRecordIdDelegate = self
        navigationController?.pushViewController(createRecordVC, animated: true)
    }
    
    // 삭제 버튼 클릭 시
    @objc private func deleteButtonClicked() {
        guard let record = detailRecordViewModel.inputRecordItem.value else { return }
        showAlert(title: "기록 삭제", message: "\(record.memo.prefix(10))을\n정말로 삭제하시겠습니까?", actionTitle: "삭제") { UIAlertAction in
            self.deleteRecord()
        }
    }
    
    // 기록 삭제하기
    private func deleteRecord() {
        guard let record = detailRecordViewModel.inputRecordItem.value else { return }
        detailRecordViewModel.deleteRecordTrigger.value = ()
        NotificationCenter.default.post(name: NSNotification.Name("RecordUpdated"), object: nil, userInfo: ["updatedDate": record.visitedAt])
        popView()
    }
    
    // 뒤로 가기
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailRecordViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.pageControl.currentPage = Int(round(mainView.imageScrollView.contentOffset.x / view.frame.width))
    }
}

extension DetailRecordViewController: PassRecordIdDelegate {
    func sendRecordId(_ id: ObjectId) {
        detailRecordViewModel.inputRecordId.value = id
    }
}

