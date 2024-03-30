//
//  RecordListCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/23/24.
//

import UIKit
import SnapKit

final class RecordListCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let recordCardView = RecordCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recordCardView.thumbnailImageView.image = nil
    }
    
    func configureCell(record: RecordItem?) {
        guard let record = record else { return }
        guard let thumbnailImage = record.images.first else { return }
        recordCardView.thumbnailImageView.image = thumbnailImage
        recordCardView.memoLabel.text = record.memo
        recordCardView.placeLabel.text = "\(record.place.title)"
        
        let image = record.isFavorite ? ImageStyle.heartFill : ImageStyle.heart
        recordCardView.heartButton.setImage(image, for: .normal)
    }
    
    func configureHierarchy() {
        contentView.addSubview(recordCardView)
    }
    func configureLayout() {
        recordCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    func configureView() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
