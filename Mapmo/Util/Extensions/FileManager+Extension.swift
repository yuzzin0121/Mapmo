//
//  FileManager+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import UIKit

class FileManagerClass {
    
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
