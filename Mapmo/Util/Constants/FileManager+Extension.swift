//
//  FileManager+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import UIKit

// TODO: - 파일 관련 오류가 발생했을 때 Error 클래스 만들기
final class FileManagerClass {
    
    // 도큐먼트/images/recordId 삭제
    func removeImagesFromDocument(recordId: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images")
        let recordIdURL = imageDirectoryURL.appendingPathComponent(recordId)
        
        if FileManager.default.fileExists(atPath: recordIdURL.path()) { // 이미지 파일이 존재하는지 확인
            do {
                try FileManager.default.removeItem(atPath: recordIdURL.path())
                print("remove images")
            } catch {
                print("file remove error", error)
            }
        } else {
            print("file no exist, remove error")
        }
    }
    
    // 도큐먼트/images/recordId/ 이미지들 가져오기
    func loadImagesToDocument(recordId: String, imageCount: Int) -> [UIImage]? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil  // nil일때 어떤 처리할지 고민해보자
        }
        
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images") // 폴더 이름 설정
        if !FileManager.default.fileExists(atPath: imageDirectoryURL.path()) {
            return nil
        }
        let recordIdURL = imageDirectoryURL.appendingPathComponent(recordId)
        if !FileManager.default.fileExists(atPath: imageDirectoryURL.path()) {
            return nil
        }
        
        var images: [UIImage] = []
        for index in 0...imageCount - 1 {
            let fileURL = recordIdURL.appendingPathComponent("\(recordId)_\(index).jpg")
            // 이 경로에 실제로 파일이 존재하는 지 확인
            if FileManager.default.fileExists(atPath: fileURL.path) {
                guard let image = UIImage(contentsOfFile: fileURL.path) else { return nil }
                images.append(image)    // 도큐먼트 파일 경로로도 이미지를 가져올 수 있다.
            } else {
                return nil
            }
        }
        
        return images
    }
    
    // 도큐먼트/images/recordId/이미지 파일들 저장
    func saveImagesToDocument(images: [UIImage], recordId: String) {
        
        // 앱 도큐먼트 위치 가져오기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        // images 폴더 url 가져오기
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images")
        
        if !FileManager.default.fileExists(atPath: imageDirectoryURL.path()) {
            // 폴더 추가하기
            do {
                try FileManager.default.createDirectory(at: imageDirectoryURL, withIntermediateDirectories: false)
        
            } catch {
                print("create images directory error", error)
            }
        }
        
        // images 폴더 url 가져오기
        let recordDirectoryURL = imageDirectoryURL.appendingPathComponent(recordId)
        
        if !FileManager.default.fileExists(atPath: recordDirectoryURL.path()) {
            // 폴더 추가하기
            do {
                try FileManager.default.createDirectory(at: recordDirectoryURL, withIntermediateDirectories: false)
            } catch {
                print("create record directory error", error)
            }
        }
        
        
        for index in 0...images.count - 1 {
            // 이미지를 저장할 경로(파일명) 지정
            let fileURL = recordDirectoryURL.appendingPathComponent("\(recordId)_\(index).jpg")
            // 이미지 압축
            guard let imageData = images[index].jpegData(compressionQuality: 0.5) else { return }
            
            // 이미지 파일 저장
            do {
                try imageData.write(to: fileURL)
                print("save images")
            } catch {
                print("file save error", error)
            }
        }
    }
}
