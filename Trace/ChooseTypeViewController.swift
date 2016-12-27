//
//  ChooseTypeViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class ChooseTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func PicEssay(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DicSetViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)

    }

}

extension ChooseTypeViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
