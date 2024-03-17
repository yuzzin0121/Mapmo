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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
    
    override func loadView() {
        view = mainView 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width, height: 154)
        layout.minimumInteritemSpacing = 16
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
}
