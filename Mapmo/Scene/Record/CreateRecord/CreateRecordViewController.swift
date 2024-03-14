//
//  CreateRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import PhotosUI

protocol PassDataDelegate: AnyObject {
    func sendPlaceItem(_ placeItem: PlaceItem)
}

final class CreateRecordViewController: BaseViewController {
    let mainView = CreateRecordView()
    let createRecordViewModel = CreateRecordViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        createRecordViewModel.inputSelectedImageList.bind { _ in
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc func addImage() { // + 버튼 눌렀을 때 -> 이미지 추가
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func addressTextFieldTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
        let searchPlaceVC = SearchPlaceViewController()
        searchPlaceVC.passPlaceDelegate = self
        navigationController?.pushViewController(searchPlaceVC, animated: true)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "기록 생성하기"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = .customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 데이터 전달 Delegate 설정
extension CreateRecordViewController: PassDataDelegate {
    func sendPlaceItem(_ placeItem: PlaceItem) {
        createRecordViewModel.inputPlaceItem.value = placeItem
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
                cell.configureCell(placeItem: createRecordViewModel.inputPlaceItem.value)
                
                
                return cell
                
            case InputRecordSection.visitDate.rawValue: // 방문 날짜
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputVisitedDateCollectionViewCell.identifier, for: indexPath) as? InputVisitedDateCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                return cell
                
            case InputRecordSection.memo.rawValue:  // 메모
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputMemoCollectionViewCell.identifier, for: indexPath) as? InputMemoCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
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
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let image = image as? UIImage {
                            images.append(image)
                            self.createRecordViewModel.inputSelectedImageList.value.append(image)
                            print("미미미미")
                        }
                        
                        if let error = error {
                            return
                        }
                    }
                } else {
                    print("이미지 가져오기 실패")
                }
            }
//            createRecordViewModel.inputSelectedImageList.value = images
        }
    }

}

