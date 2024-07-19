//
//  PlaceMarker.swift
//  Mapmo
//
//  Created by 조유진 on 4/1/24.
//

import UIKit
import NMapsMap

struct PlaceMarker {
    var address: String
    var latLng: NMGLatLng
    var recordImage: UIImage
    var categoryColorName: String
}

class PlaceMarkerView: UIView {
    var placeImageView = {
        let view = UIImageView(frame: .init(x: 0, y: 0, width: 64, height: 64))
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 2.5
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()
    
    var decorateView = {
        let view = UIView(frame: .init(x: 64 / 2 - 10 / 2, y: 64 + 6, width: 10, height: 10))
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        let imgSize = 64
        let decorationHeight = 10 + 8
        return CGSize(width: imgSize, height: imgSize + decorationHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        self.frame = CGRect(x: 0, y: 0, width: 64, height: 82)
        self.layoutIfNeeded()   // view와 자식 view의 레이아웃을 갱신 -> 캡쳐하는 시점 전에 레이아웃을 갱신
    }
    
    private func configureHierachy() {
        addSubviews([placeImageView, decorateView])
    }
    
    func configureView(data: PlaceMarker) -> UIImage {
        let color = UIColor(named: data.categoryColorName)!
        placeImageView.layer.borderColor = color.cgColor
        decorateView.backgroundColor = color
        placeImageView.image = data.recordImage
        let placeMarkerImage = self.toImage()
        return placeMarkerImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}

//final class PlaceMarker: NMFMarker {
//    let placeWindow = NMFInfoWindow()
//    var placeAddress: String?
//    var recordImage: UIImage?
//    var categoryColorName: String?
//    
//    override init() {
//        super.init()
//    }
//    
//    func setData(placeAddress: String, recordImage: UIImage, categoryColorName: String) {
//        self.placeAddress = placeAddress
//        self.recordImage = recordImage
//        self.categoryColorName = categoryColorName
//    }
//}
//
//extension PlaceMarker {
//    private func setPlaceWindow() {
//        placeWindow.dataSource = self
//    }
//    
//    func showPlaceWindow() {
//        placeWindow.open(with: self, alignType: .center)
//    }
//    
//    func hidePlaceWindow() {
//        placeWindow.close()
//    }
//}
//
//extension PlaceMarker: NMFOverlayImageDataSource {
//    func view(with overlay: NMFOverlay) -> UIView {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 58, height: 34))
//        imageView.image = ImageStyle.clock
//        imageView.layer.borderWidth = 3
//        guard let categoryColorName = categoryColorName else { return UIView() }
//        imageView.layer.borderColor = UIColor(named: categoryColorName)!.cgColor
//        return imageView
//    }
//}
