//
//  SomeImageViewController.swift
//  redirect-ui-in-app
//
//  Created by Shunsuke Sato on 2018/11/10.
//  Copyright © 2018年 Shunsuke Sato. All rights reserved.
//

import UIKit

class SomeImageViewController: UIViewController {

    let duration: Double = 0.28

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var transparent: UIView!
    @IBOutlet weak var imageView: UIImageView!

    fileprivate var presentAnimator: UIViewPropertyAnimator!
    fileprivate var dismissAnimator: UIViewPropertyAnimator!

    var presented: Bool = false
    var presentStarted: Bool = false
    var dismissStarted: Bool = false

    static func instantiate() -> SomeImageViewController {
        let sb = UIStoryboard(name: "SomeImageViewController", bundle: nil)
        return sb.instantiateInitialViewController() as! SomeImageViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.container.backgroundColor = UIColor.clear
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.presented { return }

        self.present()
    }

    @IBAction func tapped(_ sender: Any) {
        if !self.presented { return }
        if self.dismissStarted { return }

        self.dismiss()
    }
}

extension SomeImageViewController {

    func present() {
        self.presentStarted = true

        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        self.presentAnimator = UIViewPropertyAnimator(duration: self.duration, timingParameters: timing)

        self.transparent.alpha = 0.0
        self.imageView.alpha = 0.0
        self.imageView.transform = self.container.transform.scaledBy(x: 0.5, y: 0.5)

        self.presentAnimator.addAnimations {
            self.transparent.alpha = 0.8
            self.imageView.alpha = 1.0
            self.imageView.transform = CGAffineTransform.identity
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

        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        self.dismissAnimator = UIViewPropertyAnimator(duration: self.duration, timingParameters: timing)

        self.transparent.alpha = 0.7
        self.imageView.alpha = 1.0
        self.imageView.transform = CGAffineTransform.identity

        self.dismissAnimator.addAnimations {
            self.transparent.alpha = 0.0
            self.imageView.alpha = 0.0
            self.imageView.transform = self.container.transform.scaledBy(x: 0.5, y: 0.5)
        }
        self.dismissAnimator.addCompletion { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }

        self.dismissAnimator.isUserInteractionEnabled = false

        self.dismissAnimator.startAnimation()
    }
}
