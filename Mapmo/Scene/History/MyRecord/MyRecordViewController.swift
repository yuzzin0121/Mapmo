//
//  MyRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/17/24.
//

import UIKit
import FSCalendar

class MyRecordViewController: UIViewController {
    let mainView = MyRecordView()
    
    let myRecordViewModel = MyRecordViewModel()
    var passDelegate: PassDataAndShowVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        NotificationCenter.default.addObserver(self, selector: #selector(recordUpdated), name: NSNotification.Name("RecordUpdated"), object: nil)
    }
    
    @objc private func recordUpdated(notification: NSNotification) {
        let userInfo = notification.userInfo
        if let date = userInfo?["updatedDate"] as? Date {
            mainView.calendar.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width, height: 90)
        layout.minimumInteritemSpacing = 20
        mainView.collectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    
}

extension MyRecordViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return myRecordViewModel.getNumberOfEventDate(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(#function)
        myRecordViewModel.inputSelectedDate.value = date
        mainView.collectionView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
         return false  // 선택해제 불가능
    }
}

extension MyRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRecordViewModel.outputSelectedDateRecordList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = myRecordViewModel.outputSelectedDateRecordList.value[indexPath.item]
        cell.configureCell(record: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = myRecordViewModel.outputSelectedDateRecordList.value[indexPath.item]
        passDelegate?.showDetailRecordVC(recordItem: data)
    }
}

