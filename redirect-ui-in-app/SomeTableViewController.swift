//
//  SomeTableViewController.swift
//  redirect-ui-in-app
//
//  Created by Shunsuke Sato on 2018/11/10.
//  Copyright © 2018年 Shunsuke Sato. All rights reserved.
//

import UIKit

class SomeTableViewController: UIViewController {

    let list = [
        "1. Add coffee to the AeroPress",
        "2. Pour water and start timer ",
        "3. Add 70g water and stir 20 times",
        "4. Add 100g water",
        "5. Put filter cap (with wet double paper filter) in place and flip the AeroPress",
        "6. Press slowly until 1:50",
        "7. Add 75g hot water",
        "Total brew time - 1:50"
    ]

    @IBOutlet weak var tableView: UITableView!

    static func instantiate() -> SomeTableViewController {
        let sb = UIStoryboard(name: "SomeTableViewController", bundle: nil)
        return sb.instantiateInitialViewController() as! SomeTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "BigImageCell", bundle: nil),
                                forCellReuseIdentifier: "BigImageCell")
        self.tableView.register(UINib(nibName: "BigTextCell", bundle: nil),
                                forCellReuseIdentifier: "BigTextCell")
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SomeTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1 // some texts + one image
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BigImageCell") as! BigImageCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BigTextCell") as! BigTextCell
            cell.bigTextLabel.text = list[indexPath.row - 1]
            return cell
        }
    }
}
