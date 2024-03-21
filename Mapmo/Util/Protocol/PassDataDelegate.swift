//
//  PassDataDelegate.swift
//  Mapmo
//
//  Created by 조유진 on 3/20/24.
//

import Foundation
import RealmSwift

protocol PassPlaceDataDelegate: AnyObject {
    func sendPlace(_ place: Place)
}

protocol PassRecordIdDelegate: AnyObject {
    func sendRecordId(_ id: ObjectId)
}
