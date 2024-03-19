//
//  DetailRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit

class DetailRecordViewController: BaseViewController {
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
    
    private func setData(_ record: RecordItem) {
        setImages(images: record.images)
        mainView.placeInfoView.valueLabel.text = record.place.roadAddress
        mainView.visitDateInfoView.valueLabel.text = DateFormatterManager.shared.formattedVisitedDate(record.visitedAt)
        mainView.memoInfoView.memoTitleLabel.text = record.title
        mainView.memoInfoView.contentTextView.text = record.content
        
        navigationItem.title = record.place.title.htmlEscaped
    }
    
    
    private func setImages(images: [UIImage]) {
        print(images)
        print("view의 width: \(view.frame.width)")
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
    
    @objc private func editButtonClicked() {
        print(#function)
    }
    
    @objc private func deleteButtonClicked() {
        print(#function)
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailRecordViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.pageControl.currentPage = Int(round(mainView.imageScrollView.contentOffset.x / view.frame.width))
    }
}
