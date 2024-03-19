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

        detailRecordViewModel.inputRecordItem.bind { record in
            guard let record = record else { return }
            self.setData(record)
        }
    }
    
    private func setData(_ record: RecordItem) {
        mainView.placeInfoView.valueLabel.text = record.place.roadAddress
        mainView.visitDateInfoView.valueLabel.text = DateFormatterManager.shared.formattedVisitedDate(record.visitedAt)
        mainView.memoInfoView.memoTitleLabel.text = record.title
        mainView.memoInfoView.contentTextView.text = record.content
        
        navigationItem.title = record.place.title.htmlEscaped
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "기록 상세"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = ColorStyle.customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}
