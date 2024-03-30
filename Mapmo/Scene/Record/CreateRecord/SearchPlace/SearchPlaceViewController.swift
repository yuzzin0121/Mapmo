//
//  SearchPlaceViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/13/24.
//

import UIKit

final class SearchPlaceViewController: BaseViewController {
    let mainView = SearchPlaceView()
    
    let searchPlaceViewModel = SearchPlaceViewModel()
    weak var passPlaceDelegate: PassPlaceDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        searchPlaceViewModel.outputPlaceItemList.bind { [weak self] placeItemList in
            guard let self = self else { return }
            if !placeItemList.isEmpty {
                self.mainView.collectionView.reloadData()
            }
        }
        searchPlaceViewModel.outputNetworkConnect.bind { [weak self] value in
            guard let self = self else { return }
            if value == nil { return }
            self.showAlert(title: "인터넷 연결이 원활하지 않습니다.", message: "Wifi 또는 셀룰러를 활성화 해주세요", actionTitle: "확인", showCancel: false, completionHandler: nil)
        }
        
        searchPlaceViewModel.inputViewDidLoadTrigger.value = ()
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 20*2) 
        layout.itemSize = CGSize(width: width, height: 70)
        mainView.collectionView.collectionViewLayout = layout
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "장소 검색"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = ColorStyle.customBlack
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        mainView.searchController.searchBar.delegate = self
    }
    
    // 뒤로 가기
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func placeItemSelected(_ placeItem: PlaceItem) {
        if let mapx = Double(placeItem.mapx), let mapy = Double(placeItem.mapy) {
            let place = Place(address: placeItem.address,
                              lat: mapy.convertToCoordinate(),
                              lng: mapx.convertToCoordinate(),
                              title: placeItem.title.htmlEscaped,
                              link: placeItem.link,
                              modifiedAt: Date())
            passPlaceDelegate?.sendPlace(place)
            popView()
        }
        
    }
}

extension SearchPlaceViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchPlaceViewModel.inputSearchText.value = searchBar.text
        searchPlaceViewModel.searchButtonClickTrigger.value = ()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchPlaceViewModel.inputSearchText.value = searchBar.text
        searchPlaceViewModel.searchButtonClickTrigger.value = ()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchPlaceViewModel.inputSearchText.value = searchBar.text
    }
}

extension SearchPlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPlaceViewModel.outputPlaceItemList.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = searchPlaceViewModel.outputPlaceItemList.value[indexPath.item]
        cell.configureCell(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let data = searchPlaceViewModel.outputPlaceItemList.value[indexPath.item]
        placeItemSelected(data)
    }
}
