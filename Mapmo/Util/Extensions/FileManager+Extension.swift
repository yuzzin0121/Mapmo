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
        }
    }
}
