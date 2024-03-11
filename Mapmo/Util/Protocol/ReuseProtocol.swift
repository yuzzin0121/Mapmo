//
//  ReuseProtocol.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

import UIKit

protocol ReuseeProtocol: AnyObject {
    static var identifier: String { get }
}

extension UITableViewCell: ReuseeProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseeProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: ReuseeProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UIViewController: ReuseeProtocol {
    static var identifier: String {
        String(describing: self)
    }
}


