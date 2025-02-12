//
//  PhotoCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let photoImageView = UIImageView()
//    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        configureCell(image: nil)
    }
    
    // MARK: - setData
    func configureCell(image: UIImage?) {
        photoImageView.image = image
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        contentView.addSubview(photoImageView)
//        contentView.addSubview(deleteButton)
    }
    
    func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
//        deleteButton.snp.makeConstraints { make in
//            make.size.equalTo(32)
//            make.trailing.equalToSuperview().offset(12)
//            make.top.equalToSuperview().offset(-12)
//        }
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 6
        photoImageView.clipsToBounds = true
        photoImageView.isUserInteractionEnabled = true
        
//        deleteButton.setImage(ImageStyle.xCircle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
