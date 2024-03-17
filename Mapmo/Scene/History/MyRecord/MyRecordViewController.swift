//
//  MyRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/17/24.
//

import UIKit

class MyRecordViewController: UIViewController {
    let mainView = MyRecordView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = mainView 
    }
}
