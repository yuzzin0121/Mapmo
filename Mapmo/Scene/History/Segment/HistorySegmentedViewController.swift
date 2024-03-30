//
//  HistorySegmentedViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/17/24.
//

import UIKit
import Tabman
import Pageboy

final class HistorySegmentedViewController: TabmanViewController {
    let tabView = {
        let view = UIView()
        view.backgroundColor = ColorStyle.customWhite
        view.layer.addBorder([.bottom], color: ColorStyle.customGray, width: 1.0)
        return view
    }()
    
    var viewControllers: [UIViewController] = []
    let tabTitles = ["나의 기록"]
    weak var passDelegate: PassDataAndShowVCDelegate?
    weak var showCreateDelegate: ShowCreateRecordDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorStyle.customWhite
        configureHierachy()
        configureLayout()
        addViewControllers()
        setDelegate()
        createBar()
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    func createBar() {
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .clear
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bar.buttons.customize { (button) in
            button.tintColor = ColorStyle.customGray
            button.font = .pretendard(size: 16, weight: .regular)
            button.selectedFont = .pretendard(size: 16, weight: .bold)
            button.selectedTintColor = ColorStyle.customBlack
        }
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = ColorStyle.customBlack
        bar.indicator.overscrollBehavior = .compress
//        bar.layout.interButtonSpacing = 35 // 버튼 사이 간격
        bar.layout.contentMode = .fit
        
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }
    
    private func addViewControllers() {
        let myRecordVC = MyRecordViewController()
        
        myRecordVC.passDelegate = self
        myRecordVC.showCreateRecordDelegate = self
        
        viewControllers.append(contentsOf: [myRecordVC])
    }
    
    private func setDelegate() {
        dataSource = self
    }

    private func configureHierachy() {
        view.addSubview(tabView)
    }
    
    private func configureLayout() {
        tabView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view)
            make.height.equalTo(48)
        }
    }
    
}

extension HistorySegmentedViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = tabTitles[index]
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return .at(index: 0)
    }
    
    
}

extension HistorySegmentedViewController: PassDataAndShowVCDelegate {
    func showDetailRecordVC(recordItem: RecordItem) {
        passDelegate?.showDetailRecordVC(recordItem: recordItem)
    }
}

extension HistorySegmentedViewController: ShowCreateRecordDelegate {
    func showCreateRecordVC() {
        showCreateDelegate?.showCreateRecordVC()
    }
}
