//
//  CreateRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import RealmSwift
import NMapsMap

enum EditedValue {
    case images
    case place
}

final class CreateRecordViewModel {
    var inputSelectedCategory: Observable<Category?> = Observable(nil)  // 선택된 카테고리
    var inputRecordSectionList: Observable<[InputRecordSection]> = Observable(InputRecordSection.allCases)
    
    var inputSelectedImageList: Observable<[UIImage]> = Observable([])  // 선택된 이미지 리스트
    var inputPlace: Observable<Place?> = Observable(nil)                // 선택된 장소
    var inputVisitDate: Observable<Date> = Observable(Date())           // 방문 시간
    var inputMemo: Observable<String?> = Observable(nil)                // 메모
    var isActivate: Observable<Bool> = Observable(false)                // 버튼 활성화 여부
    var createRecordTrigger: Observable<Void?> = Observable(nil)        // 생성 클릭 시
    var editRecordTrigger: Observable<Void?> = Observable(nil)          // 수정 클릭 시
    var createdAt: Date?
    var createSuccess: Observable<Bool> = Observable(false)             // 생성 성공 여부
    var editSuccess: Observable<ObjectId?> = Observable(nil)
    
    
    let contentTextViewPlaceholder = "메모 입력"
    lazy var placeRepository = PlaceRepository()
    lazy var recordRepository = RecordRepository()
    lazy var categoryRepository = CategoryRepository()
    lazy var fileManagerClass = FileManagerClass()

    var previousVC: PreviousVC?     // 이전 화면
    var recordId: ObjectId?         // 상세 화면에서 전달받을 기록 아이디
    var isFavorite: Bool?           // 상세 화면에서 전달받을 좋아요 여부
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSelectedImageList.bind { imageList in
            print("이미지 변경됨")
            self.checkData()
        }
        inputPlace.bind { place in
            guard let place = place else { return }
            print("장소 있음")
            self.checkData()
        }
        inputMemo.bind { memo in
            if memo == nil { return }
            print("메모 있음")
            self.checkData()
        }
        
        createRecordTrigger.bind { value in
            guard let value = value else { return }
            self.createRecord()
        }
        editRecordTrigger.bind { value in
            guard let value = value else { return }
            self.editRecord()
        }
    }
    
    // 이미지, 카테고리, 장소, 메모 데이터 유무 확인
    func checkData() {
        guard let memo = inputMemo.value else {
            print("메모 없음")
            isActivate.value = false
            return
        }
        if !inputSelectedImageList.value.isEmpty && inputSelectedCategory.value != nil && inputPlace.value != nil && !memo.isEmpty {
            // 생성할 데이터들이 존재할 때: 생성 버튼 활성화 해야한다. , Realm에 Record, Place(중복 확인) 저장
            print("활성화 성공")
            isActivate.value = true
        } else {
            print("활성화 실패")
            isActivate.value = false
        }
    }
    
    // 기록 수정
    private func editRecord() {
        guard let place = inputPlace.value, 
                let recordId = recordId,
                let category = inputSelectedCategory.value  else {
            isActivate.value = false
            return
        }
        
        guard let memo = inputMemo.value, let isFavorite = isFavorite else { return }
        if inputSelectedImageList.value.isEmpty {
            return
        }
        
        let record = Record(memo: memo,
                                imageCount: inputSelectedImageList.value.count,
                                visitedAt: inputVisitDate.value,
                                createdAt: createdAt ?? Date(),
                                modifiedAt: Date(),
                                isFavorite: isFavorite,
                                categoryId: category.name)
        
        // 이미지 변경됐을 경우
        editImages(recordId: recordId.stringValue)
        
        // 장소 변경됐을 경우
        if placeRepository.isExistPlace(place) {    // 존재하면, 이미 있는 장소에 Record 생성 및 추가
        } else {
            placeRepository.createPlace(place)  // 존재하지 않으면, 장소 생성 + Reacord 생성 및 생성된 장소에 추가
        }
        recordRepository.updateRecord(record, recordId: recordId, place: place)
        editSuccess.value = recordId
    }
    
    private func editImages(recordId: String) {
        if inputSelectedImageList.value.isEmpty {
            isActivate.value = false
        }
        fileManagerClass.removeImagesFromDocument(recordId: recordId)
        fileManagerClass.saveImagesToDocument(images: inputSelectedImageList.value, recordId: recordId)
    }
    
    private func createRecord() {
        guard let place = inputPlace.value, let record = self.getRecord(), let category = inputSelectedCategory.value  else {
            isActivate.value = false
            return
        }
        
        if placeRepository.isExistPlace(place) {    // 존재하면, 이미 있는 장소에 Record 생성 및 추가
            print("이미 장소 등록되어있음")
        } else {
            print("장소 등록 안되어있음")
            placeRepository.createPlace(place)  // 존재하지 않으면, 장소 생성 + Reacord 생성 및 생성된 장소에 추가
            
        }
        recordRepository.createRecord(record, place: place)
        if !inputSelectedImageList.value.isEmpty {
            fileManagerClass.saveImagesToDocument(images: inputSelectedImageList.value, recordId: record.id.stringValue)
        }
        createSuccess.value = true
    }
    
    private func getRecord() -> Record? {
        guard let category = inputSelectedCategory.value, let memo = inputMemo.value else { return nil }
        if inputSelectedImageList.value.isEmpty {
            return nil
        }
        
        let record = Record(
                            memo: memo,
                            imageCount: inputSelectedImageList.value.count,
                            visitedAt: inputVisitDate.value,
                            createdAt: createdAt ?? Date(),
                            modifiedAt: Date(),
                            categoryId: category.name)
        return record
    }
    
}
