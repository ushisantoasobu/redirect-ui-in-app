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
        "Total brew time - 1:50",
        "Following the completion of 140 events across the globe, 61 national champions have emerged. They will now represent their country on the biggest W.A.C stage ever. \rOur events are a rare opportunity to gather coffee-loving people from all over the world and so, in the spirit of our true-blue Aussie hospitality, we’re getting out the barbie and throwing a little get-together. "
    ]

    let duration: Double = 1.0

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableView: UITableView!

    fileprivate var presentAnimator: UIViewPropertyAnimator!
    fileprivate var dismissAnimator: UIViewPropertyAnimator!

    var tempTransform: CGAffineTransform!
    var presented: Bool = false
    var presentStarted: Bool = false
    var dismissStarted: Bool = false

    static func instantiate() -> SomeTableViewController {
        let sb = UIStoryboard(name: "SomeTableViewController", bundle: nil)
        return sb.instantiateInitialViewController() as! SomeTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "BigImageCell", bundle: nil),
                                forCellReuseIdentifier: "BigImageCell")
        self.tableView.register(UINib(nibName: "BigTextCell", bundle: nil),
                                forCellReuseIdentifier: "BigTextCell")

        self.container.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.presented { return }

        self.present()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        // compromise > <...
//        guard indexPath.row == 0 else { return }

        let vc = SomeImageViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.presented { return }
        if !self.presentStarted { return }
        if self.dismissStarted { return }

        let threshold: CGFloat = -40

        print("@@@@@: \(scrollView.contentOffset.y)")

        if scrollView.contentOffset.y < threshold {
            self.dismiss()
        }
    }
}

// about animation
extension SomeTableViewController {

    func present() {
        self.presentStarted = true

        let timing = UICubicTimingParameters(animationCurve: .easeIn)
        self.presentAnimator = UIViewPropertyAnimator(duration: self.duration, timingParameters: timing)

        self.container.transform = self.container.transform.translatedBy(x: 0,
                                                                         y: self.view.frame.height)
        self.container.isHidden = false

        self.presentAnimator.addAnimations {
            self.container.transform = CGAffineTransform.identity
        }

        self.presentAnimator.addCompletion { [weak self] _ in
            self?.presented = true
        }

        self.presentAnimator.startAnimation()
    }

    func dismiss() {
        self.dismissStarted = true

        self.presentAnimator.stopAnimation(true)
        
        self.view.isUserInteractionEnabled = false
        self.view.resignFirstResponder()

        tempTransform = self.container.transform

        self.container.transform = tempTransform

        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        let height = Double(self.view.frame.height)
        let height2 = Double(self.container.transform.ty)
        let percent = self.duration // * (height - height2) / height

        self.dismissAnimator = UIViewPropertyAnimator(duration: percent, timingParameters: timing)

        self.dismissAnimator.addAnimations {
            self.container.transform = self.container.transform.translatedBy(x: 0, y: self.view.frame.height)
        }
        self.dismissAnimator.addCompletion { _ in

            self.dismiss(animated: false, completion: nil)
        }

        self.dismissAnimator.isUserInteractionEnabled = false

        self.dismissAnimator.startAnimation()
    }
}
