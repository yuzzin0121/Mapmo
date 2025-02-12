//
//  CreateRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import PhotosUI

final class CreateRecordViewController: BaseViewController {
    let mainView = CreateRecordView()
    let createRecordViewModel = CreateRecordViewModel()
    weak var passEditedRecordDelegate: PassEditedRecordDelegate?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setDelegate()
        createRecordViewModel.inputSelectedImageList.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
        
        createRecordViewModel.isActivate.bind { [weak self] isActivate in
            guard let self = self else { return }
            self.mainView.createButton.isEnabled = isActivate
            self.mainView.createButton.backgroundColor = isActivate ? ColorStyle.mapmoColor : ColorStyle.null
        }
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
        createRecordViewModel.checkData()
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.createButton.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
    }
    
    private func configureView() {
        if let previousVC = createRecordViewModel.previousVC {
            switch previousVC {
            case .detailRecord:
                mainView.createButton.setTitle("수정하기", for: .normal)
            case .selectCatgory:
                mainView.createButton.setTitle("생성하기", for: .normal)
            }
        }
    }
    
    // 생성 또는 수정하기 클릭 시
    @objc private func createButtonClicked(_ sender: UIButton) {
        print(#function)
        
        if let previousVC = createRecordViewModel.previousVC {
            print(previousVC)
            switch previousVC {
            case .detailRecord:
                createRecordViewModel.editRecordTrigger.value = ()
                createRecordViewModel.editSuccess.bind { [weak self] recordItem in
                    guard let recordItem, let self = self else { return }
                    passEditedRecordDelegate?.sendRecordItem(recordItem)
                    NotificationCenter.default.post(name: NSNotification.Name("RecordUpdated"), object: nil, userInfo: ["updatedDate": self.createRecordViewModel.inputVisitDate.value])
                    popView()
                }
            case .selectCatgory:
                createRecordViewModel.createRecordTrigger.value = ()
                createRecordViewModel.createSuccess.bind { [weak self] success in
                    guard let self = self else { return }
                    if success {
                        self.showMainTabBar()
                    }
                }
            }
        }
    }
    
    // 이미지 추가 버튼(+) 클릭했을 때 - 이미지 선택 화면(PHPickerViewController) 띄우기
    @objc func addImage() { // + 버튼 눌렀을 때 -> 이미지 추가
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // 주소 버튼을 클릭했을 때 - 주소 검색 화면으로 화면 전환
    @objc func addressTextFieldTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
        let searchPlaceVC = SearchPlaceViewController()
        searchPlaceVC.passPlaceDelegate = self
        navigationController?.pushViewController(searchPlaceVC, animated: true)
    }
    
    // DatePicker 값을 선택했을 때
    @objc func datePickerSelected(_ sender: UIDatePicker) {
        createRecordViewModel.inputVisitDate.value = sender.date
    }
    
    // 제목 텍스트필드 값 변경될 때
    @objc func titleTextFieldEditingChanged(_ sender: UITextField) {
        createRecordViewModel.inputMemo.value = sender.text
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        if let previousVC = createRecordViewModel.previousVC {
            switch previousVC {
            case .detailRecord:
                navigationItem.title = "맵모 수정하기"
            case .selectCatgory:
                navigationItem.title = "맵모 생성하기"
            }
        }
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = .customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteImageButtonClicked(_ sender: UIButton) {
        print(#function)
        let index = sender.tag
        createRecordViewModel.inputDeleteImageIndex.value = index
    }
}

// MARK: - 데이터 전달 Delegate 설정
extension CreateRecordViewController: PassPlaceDataDelegate {
    func sendPlace(_ place: Place) {
        createRecordViewModel.inputPlace.value = place
        mainView.collectionView.reloadItems(at: [IndexPath(item: InputRecordSection.place.rawValue, section: 0)])
    }
}


// MARK: - 기록 입력, 이미지 추가 컬렉션뷰 설정
extension CreateRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return createRecordViewModel.inputSelectedImageList.value.count
        } else {
            return createRecordViewModel.inputRecordSectionList.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {    // 이미지 리스트 컬렉션뷰일 때
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            let data = createRecordViewModel.inputSelectedImageList.value[indexPath.item]
            cell.configureCell(image: data)
//            cell.deleteButton.tag = indexPath.item
//            cell.deleteButton.addTarget(self, action: #selector(deleteImageButtonClicked), for: .touchUpInside)
            return cell
        } else {
            switch indexPath.item {
            case InputRecordSection.photo.rawValue: // 이미지 추가
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCollectionViewCell.identifier, for: indexPath) as? AddPhotoCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.collectionView.tag = 1
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.addPhotoButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
                cell.setEmptyUI(createRecordViewModel.inputSelectedImageList.value.isEmpty)
                return cell
            case InputRecordSection.place.rawValue: // 장소
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputPlaceCollectionViewCell.identifier, for: indexPath) as? InputPlaceCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.addressButton.addTarget(self, action: #selector(addressTextFieldTapped), for: .touchUpInside)
                cell.configureCell(place: createRecordViewModel.inputPlace.value)
                
                
                return cell
                
            case InputRecordSection.visitDate.rawValue: // 방문 날짜
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputVisitedDateCollectionViewCell.identifier, for: indexPath) as? InputVisitedDateCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.datePicker.addTarget(self, action: #selector(datePickerSelected), for: .valueChanged)
                cell.datePicker.date = createRecordViewModel.inputVisitDate.value
                return cell
                
            case InputRecordSection.memo.rawValue:  // 메모
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputMemoCollectionViewCell.identifier, for: indexPath) as? InputMemoCollectionViewCell else {
                    return UICollectionViewCell()
                }
               
                cell.memoTextView.delegate = self
                cell.memoTextView.text = createRecordViewModel.inputMemo.value
                
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    // 셀 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            let width = (view.frame.width - 40 - 20*2 + 8) / 2
            return CGSize(width: width, height: 148)
        } else {
            switch indexPath.item {
            case InputRecordSection.photo.rawValue:
                return CGSize(width: view.frame.width, height: InputRecordSection.photo.cellHeight)
            case InputRecordSection.place.rawValue:
                return CGSize(width: view.frame.width, height: InputRecordSection.place.cellHeight)
            case InputRecordSection.visitDate.rawValue:
                return CGSize(width: view.frame.width, height: InputRecordSection.visitDate.cellHeight)
            case InputRecordSection.memo.rawValue:
                return CGSize(width: view.frame.width, height: InputRecordSection.memo.cellHeight)
            default:
                return CGSize(width: view.frame.width, height: 100)
            }
        }
        
    }
    
}

// MARK: - 이미지 추가 delegate 설정
extension CreateRecordViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if !(results.isEmpty) {
            var images: [UIImage] = []
            for result in results {
                let itemProvider = result.itemProvider
                
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self else { return }
                        if let image = image as? UIImage {
                            images.append(image)
                            self.createRecordViewModel.inputSelectedImageList.value.append(image)
                        }
                        
                        if error != nil {
                            return
                        }
                    }
                } else {
                    print("이미지 가져오기 실패")
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension CreateRecordViewController: UITextViewDelegate {
    // textView에 focus를 얻는 경우 발생
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == createRecordViewModel.contentTextViewPlaceholder {
            textView.textColor = ColorStyle.customBlack
        }
    }
    
    // textView에 focus를 잃는 경우 발생
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = createRecordViewModel.contentTextViewPlaceholder
            textView.textColor = ColorStyle.customGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        createRecordViewModel.inputMemo.value = textView.text
    }
    
}
