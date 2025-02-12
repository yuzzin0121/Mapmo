//
//  MapViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit
import CoreLocation
import FloatingPanel
import NMapsMap
import NMapsGeometry

final class MapViewController: BaseViewController {
    
    let mainView = MapView()
    
    let mapViewModel = MapViewModel()
    var floatingPanelC: FloatingPanelController!
    let mapRecordListVC = MapRecordListViewController()
    let locationManager = CLLocationManager()
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAction()
        setFloatingPanelC()
        setDelegate()
        setBinding()
        mapViewModel.moveCameraPlaceTrigger.value = ()
//      getCurrentRegion()  // 현재 위치로 이동
        recordUpdated()
        
        NotificationCenter.default.addObserver(self, selector: #selector(recordUpdated), name: NSNotification.Name("RecordUpdated"), object: nil)
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    private func setBinding() {
        // 기록 추가 버튼 클릭 시
        mapViewModel.addRecordButtonTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            showAddRecordVC()
        }
        
        // 현재 위치로 이동
        mapViewModel.outputCurrentLatLng.bind { [weak self] currentLatLng in
            guard let currentLatLng = currentLatLng, let self else { return }
            moveCamera(latLng: currentLatLng)
        }
        
        // 최근 수정된 장소로 카메라 이동
        mapViewModel.outputRecentPlaceLatLng.bind { [weak self] recentPlaceLatLng in
            guard let recentPlaceLatLng = recentPlaceLatLng, let self else { return }
            moveCamera(latLng: recentPlaceLatLng)
        }
        
        // 장소들 마커에 등록
        mapViewModel.outputPlaceMarkers.bind { [weak self] markers in
            guard let self = self else { return }
            for marker in markers {
                marker.mapView = self.mainView.naverMapView
            }
        }
        
        // 현재 위치의 기록들 리스트VC에 전달
        mapViewModel.outputRecordList.bind { [weak self] recordList in
            guard let self = self else { return }
            self.mapRecordListVC.mapRecordListViewModel.inputRecordList.value = recordList
        }
    }
    
    @objc private func recordUpdated() {
        mapViewModel.moveCameraPlaceTrigger.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func moveCamera(latLng: NMGLatLng) {
        print(#function, latLng)
        let cameraUpdate = NMFCameraUpdate(scrollTo: latLng)
        mainView.naverMapView.moveCamera(cameraUpdate)
    }
    
    private func getCurrentRegion() {
        let visibleRegion = mainView.naverMapView.contentBounds
        mapViewModel.inputVisibleRegion.value = visibleRegion
    }
    
    private func setDelegate() {
        floatingPanelC.delegate = self
        locationManager.delegate = self
        mapRecordListVC.passDelegate = self
        mapRecordListVC.showCreateRecordDelegate = self
        mainView.naverMapView.addCameraDelegate(delegate: self)
    }
    
    private func setFloatingPanelC() {
        floatingPanelC = FloatingPanelController()
        floatingPanelC.set(contentViewController: mapRecordListVC)
        floatingPanelC.track(scrollView: mapRecordListVC.mainView.collectionView)
        floatingPanelC.addPanel(toParent: self)
        floatingPanelC.designPanel()
        floatingPanelC.show()
        floatingPanelC.layout = MyFloatingPanelLayout()
    }
    
    private func showAddRecordVC() {
        print(#function)
        let selectCategoryVC = SelectCategoryViewController()
        selectCategoryVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(selectCategoryVC, animated: true)
    }
    
    @objc private func moveCurrentLoactionButtonClicked(_ sender: UIButton) {
        checkDeviceLocationAuthorization()
    }
    
    @objc private func addRecordButtonClicked(_ sender: UIButton) {
        print(#function)
        mapViewModel.addRecordButtonTrigger.value = ()
    }
    
    private func setAction() {
        mainView.moveCurrentLoactionButton.addTarget(self, action: #selector(moveCurrentLoactionButtonClicked), for: .touchUpInside)
        mainView.addRecordButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
    }
    
    override func loadView() {
        view = mainView
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가지고 온 경우 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            mapViewModel.inputCurrentLocation.value = coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가져오는데 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    // 4) 사용자 권한 상태가 바뀔 떄를 알려줌 - 변경된 후에 앱을 다시 켜도 감지를 한다
    // 거부했다가 설정에서 허용으로 바꾸거나, notDetermined에서 허용을 했거나 허용해서 위치를 갖고 오는 도중에 다시 설정에서 거부를 하거나
    // iOS14 이상...
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
}

extension MapViewController {
    // 1) 사용자에게 권한 요청을 하기 위해, iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        
        // UI와 직결되어있지 않은 부분은 다른 알바생에게 맡겨랑!
        DispatchQueue.global().async {
            // 타입 메서드로 구현되어있음⭐️
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태 확인
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)   // 권한상태 전달
                }
            } else {
                print("위치 서비스가 꺼져있어서, 위치 권한 요청을 할 수 없어요.")  // print로 대체하는 부분은 사용자에게 알려줘야 되는 부분이당
            }
        }
    }
    
    
    // 2) 사용자 위치 권한 상태 확인 후, 권한 요청 (처음에 들어왔다면,
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
   
        switch status {
        case .notDetermined:    // 앱을 처음 켰을 때 아직 권한이 결정되지 않은 상태 (권한이 아직 뜨지 않은 상태) => 권한 문구 띄우기 or 한번만 허용을 클릭했을 때
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:           // 허용 안함 클릭했을 때
            print("denied")
            showLocationSettingAlert()
        case .authorizedWhenInUse:  // 앱을 사용하는 동안 허용
            print("authorizedWhenInUse")
            // 사용자가 허용했으면 locationManager를 통해 startUpdationgLocation() 메서드 실행 -> didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation()
        default:
            print("Error")
        }
    }
    
    
    // 3) 설정으로 이동해주는 기능이 있는 Alert
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            // 아이폰 설정으로 이동: 무조건 설정으로 이동해줘서 킬 수 있도록 유도해야 함!
            // 설정 화면에 갈지, 앱 상세 페이지까지 유도해줄지는 몰라요...
            // 한번도 직접 설정에서 사용자가 앱 상세 페이지까지 들어간적이 없다면
            // 막 다운 받은 앱이라서 설정 상세 페이지까지 갈 준비가 시스템적으로 안돼있을 수 있음
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가주세여")
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true)
        
    }
}

extension MapViewController: PassDataAndShowVCDelegate {
    func showDetailRecordVC(recordItem: RecordItem) {
        let detailRecordVC = DetailRecordViewController()
        detailRecordVC.detailRecordViewModel.inputRecordItem.value = recordItem
        detailRecordVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailRecordVC, animated: true)
    }
}

extension MapViewController: ShowCreateRecordDelegate {
    func showCreateRecordVC() {
        mapViewModel.addRecordButtonTrigger.value = ()
    }
}

extension MapViewController: NMFMapViewCameraDelegate {
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        getCurrentRegion()
    }
}

extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .full {
            
        } else {
            
        }
    }
}

// MARK: 플로팅 패널
final class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .tip
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 292, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.1, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}

