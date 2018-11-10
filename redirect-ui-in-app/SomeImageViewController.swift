//
//  SomeImageViewController.swift
//  redirect-ui-in-app
//
//  Created by Shunsuke Sato on 2018/11/10.
//  Copyright © 2018年 Shunsuke Sato. All rights reserved.
//

import UIKit

class SomeImageViewController: UIViewController {

    static func instantiate() -> SomeImageViewController {
        let sb = UIStoryboard(name: "SomeImageViewController", bundle: nil)
        return sb.instantiateInitialViewController() as! SomeImageViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
