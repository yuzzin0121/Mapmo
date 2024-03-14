//
//  SearchPlaceViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/13/24.
//

import UIKit

class SearchPlaceViewController: BaseViewController {
    let mainView = SearchPlaceView()
    
    let searchPlaceViewModel = SearchPlaceViewModel()
    var passPlaceDelegate: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        searchPlaceViewModel.outputPlaceItemList.bind { placeItemList in
            if !placeItemList.isEmpty {
                self.mainView.collectionView.reloadData()
            }
        }
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
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func placeItemSelected(_ placeItem: PlaceItem) {
        passPlaceDelegate?.sendPlaceItem(placeItem)
        navigationController?.popViewController(animated: true)
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
