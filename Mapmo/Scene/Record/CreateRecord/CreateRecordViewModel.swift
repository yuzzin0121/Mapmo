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
    var inputPlaceItem: Observable<PlaceItem?> = Observable(nil)
    var inputVisitDate: Observable<Date?> = Observable(nil)
    var inputTitleText: Observable<String?> = Observable(nil)
    var inputContentText: Observable<String?> = Observable(nil)
    var isActivate: Observable<Bool> = Observable(false)
    var createRecordTrigger: Observable<Void?> = Observable(nil)
    
    var createSuccess: Observable<Bool> = Observable(false)
    
    let contentTextViewPlaceholder = "내용 입력"
    lazy var placeRepository = PlaceRepository()
    lazy var recordRepository = RecordRepository()
    lazy var categoryRepository = CategoryRepository()
    lazy var fileManagerClass = FileManagerClass()

    
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
        inputPlaceItem.bind { placeItem in
            guard let placeItem = placeItem else { return }
            self.checkData()
        }
        inputVisitDate.bind { visitDate in
            guard let visitDate = visitDate else { return }
            self.checkData()
        }
        inputTitleText.bind { titleText in
            if self.inputTitleText.value == nil { return }
            self.checkData()
        }
        createRecordTrigger.bind { value in
            guard let value = value else { return }
            self.checkIsExistPlace()
        }
    }
    
    private func checkData() {
        guard let titleText = inputTitleText.value else { return }
        if inputSelectedCategory.value != nil && !inputSelectedImageList.value.isEmpty
            && inputPlaceItem.value != nil && !titleText.isEmpty {
            // 생성할 데이터들이 존재할 때: 생성 버튼 활성화 해야한다. , Realm에 Record, Place(중복 확인) 저장
            isActivate.value = true
        } else {
            isActivate.value = false
        }
    }
    
    private func checkIsExistPlace() {
        guard let placeItem = inputPlaceItem.value else { return }
        var place: Place?
        
        if let mapx = Int(placeItem.mapx), let mapy = Int(placeItem.mapy) {
            print("mapx\(mapx), mapy\(mapy)")
            
//            let mapTm128 = NMGTm128(x: mapx, y: mapy)
//            print("maptm128\(mapTm128)")
//            let latLng = mapTm128.toLatLng()
//            print("latx\(latLng.lat), laty\(latLng.lng)")
            let x = mapx.convertToCoordinate()
            let y = mapy.convertToCoordinate()
            print("10,000,000으로 나눈 좌표\(x),\(y)")
            
            place = Place(roadAddress: placeItem.roadAddress,
                              mapx: y,
                              mapy: x,
                              title: placeItem.title,
                              link: placeItem.link)
        }
        
        guard let place = place, let record = self.createRecord(), let category = inputSelectedCategory.value  else { return }
        
        
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
        categoryRepository.updateCategorysRecordCount(category: category, count: category.recordCount + 1)
        createSuccess.value = true
    }
    
    private func createRecord() -> Record? {
        guard let category = inputSelectedCategory.value, let title = inputTitleText.value, let visitDate = inputVisitDate.value else { return nil }
        if inputSelectedImageList.value.isEmpty {
            return nil
        }
        
        let record = Record(title: title,
                            content: inputContentText.value, 
                            imageCount: inputSelectedImageList.value.count,
                            visitedAt: visitDate,
                            createdAt: Date(),
                            modifiedAt: Date(),
                            categoryId: category.name)
        return record
    }
    
}
