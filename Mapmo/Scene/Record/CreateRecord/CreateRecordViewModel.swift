//
//  CreateRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import RealmSwift
import NMapsMap

class CreateRecordViewModel {
    var inputSelectedCategory: Observable<Category?> = Observable(nil)
    var inputRecordSectionList: Observable<[InputRecordSection]> = Observable(InputRecordSection.allCases)
    
    var inputSelectedImageList: Observable<[UIImage]> = Observable([])
    var inputPlace: Observable<Place?> = Observable(nil)
    var inputVisitDate: Observable<Date> = Observable(Date())
    var inputMemo: Observable<String?> = Observable(nil)
    var isActivate: Observable<Bool> = Observable(false)
    var createRecordTrigger: Observable<Void?> = Observable(nil)
    var editRecordTrigger: Observable<Void?> = Observable(nil)
    
    var createSuccess: Observable<Bool> = Observable(false)
    
    let contentTextViewPlaceholder = "내용 입력"
    lazy var placeRepository = PlaceRepository()
    lazy var recordRepository = RecordRepository()
    lazy var categoryRepository = CategoryRepository()
    lazy var fileManagerClass = FileManagerClass()

    var previousVC: PreviousVC?
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSelectedImageList.bind { imageList in
            if imageList.isEmpty {
                
            } else {
                self.checkData()
            }
        }
        inputPlace.bind { place in
            guard let place = place else { return }
            self.checkData()
        }
        inputMemo.bind { memo in
            if memo == nil { return }
            self.checkData()
        }
        inputVisitDate.bind { date in
            self.checkData()
        }
        createRecordTrigger.bind { value in
            guard let value = value else { return }
            self.checkIsExistPlace()
        }
        editRecordTrigger.bind { value in
            guard let value = value else { return }
            
        }
    }
    
    private func checkData() {
        guard let memo = inputMemo.value else {
            isActivate.value = false
            return
        }
        if inputSelectedCategory.value != nil && !inputSelectedImageList.value.isEmpty
            && inputPlace.value != nil && !memo.isEmpty {
            // 생성할 데이터들이 존재할 때: 생성 버튼 활성화 해야한다. , Realm에 Record, Place(중복 확인) 저장
            isActivate.value = true
        } else {
            isActivate.value = false
        }
    }
    
    private func checkIsExistPlace() {
        guard let place = inputPlace.value, let record = self.createRecord(), let category = inputSelectedCategory.value  else {
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
    
    private func createRecord() -> Record? {
        guard let category = inputSelectedCategory.value, let memo = inputMemo.value else { return nil }
        if inputSelectedImageList.value.isEmpty {
            return nil
        }
        
        let record = Record(memo: memo,
                            imageCount: inputSelectedImageList.value.count,
                            visitedAt: inputVisitDate.value,
                            createdAt: Date(),
                            modifiedAt: Date(),
                            categoryId: category.name)
        return record
    }
    
}
