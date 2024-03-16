//
//  MapViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit
import FloatingPanel

final class MapViewController: BaseViewController {
    let mainView = MapView()
    
    let mapViewModel = MapViewModel()
    var floatingPanelC: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAction()
        setFloatingPanelC()
        mapViewModel.addRecordButtonTrigger.bind { value in
            guard let value = value else { return }
            self.showAddRecordVC()
        }
        
    }
    
    private func setFloatingPanelC() {
        floatingPanelC = FloatingPanelController()
        floatingPanelC.delegate = self
        
        let mapRecordListVC = MapRecordListViewController()
        floatingPanelC.set(contentViewController: mapRecordListVC)
        floatingPanelC.track(scrollView: mapRecordListVC.mainView.tableView)
        floatingPanelC.addPanel(toParent: self)
        floatingPanelC.designPanel()
        floatingPanelC.show()
        floatingPanelC.layout = MyFloatingPanelLayout()
        
    }
    
    private func showAddRecordVC() {
        let selectCategoryVC = SelectCategoryViewController()
        selectCategoryVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(selectCategoryVC, animated: true)
    }
    
    @objc private func addRecordButtonClicked() {
        mapViewModel.addRecordButtonTrigger.value = ()
    }
    
    private func setAction() {
        mainView.addRecordButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
    }
    
    override func loadView() {
        view = mainView
    }
    
}

extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .full {
            
        } else {
            
        }
    }
}


class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .tip
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 292, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 110, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}

