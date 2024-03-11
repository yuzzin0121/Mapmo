//
//  AddCategoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

class AddCategoryViewController: BaseViewController {
    let mainView = AddCategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = mainView
    }

}
