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
    var showCreateRecordDelegate: ShowCreateRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        NotificationCenter.default.addObserver(self, selector: #selector(recordUpdated), name: NSNotification.Name("RecordUpdated"), object: nil)
        myRecordViewModel.outputSelectedDateRecordList.bind { recordItem in
            self.mainView.calendar.reloadData()
            self.setEmptyUI(recordItem.isEmpty)
        }
    }
    
    private func setEmptyUI(_ isEmpty: Bool) {
        mainView.emptyMessaageLabel.isHidden = !isEmpty
    }
    
    @objc private func recordUpdated(notification: NSNotification) {
        let userInfo = notification.userInfo
        if let date = userInfo?["updatedDate"] as? Date {
            mainView.calendar.reloadData()
            calendar(mainView.calendar, didSelect: Date(), at: .current)
        } else {
            calendar(mainView.calendar, didSelect: myRecordViewModel.inputSelectedDate.value, at: .current)
        }
    }
    
    override func loadView() {
        view = mainView 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: mainView.frame.width, height: 95)
        layout.minimumLineSpacing = 18
        mainView.collectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc private func addRecordButtonClicked(_ sender: UIButton) {
        showCreateRecordDelegate?.showCreateRecordVC()
    }
    
    @objc private func heartButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        myRecordViewModel.toggleIsFavorite.value = index
        NotificationCenter.default.post(name: NSNotification.Name("RecordUpdated"), object: nil, userInfo: nil)
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

extension MyRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecordCollectionReusableView.identifier, for: indexPath) as? RecordCollectionReusableView else {
                return UICollectionReusableView()
            }
            headerView.setData(count: myRecordViewModel.outputSelectedDateRecordList.value.count)
            headerView.addRecordButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRecordViewModel.outputSelectedDateRecordList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = myRecordViewModel.outputSelectedDateRecordList.value[indexPath.item]
        cell.configureCell(record: data)
        cell.heartButton.tag = indexPath.item
        cell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = myRecordViewModel.outputSelectedDateRecordList.value[indexPath.item]
        passDelegate?.showDetailRecordVC(recordItem: data)
    }
}

