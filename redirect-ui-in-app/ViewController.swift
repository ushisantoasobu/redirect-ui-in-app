//
//  ViewController.swift
//  redirect-ui-in-app
//
//  Created by Shunsuke Sato on 2018/11/10.
//  Copyright © 2018年 Shunsuke Sato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapped(_ sender: Any) {
        let vc = SomeTableViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
}

