//
//  MainPageViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet var newDay: UIButton!
    @IBOutlet var passDay: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHight = UIScreen.main.bounds.height
        let buttonHight = newDay.frame.height
        let off:CGFloat = 50
        let y_newDay = screenHight/2 - off - buttonHight
        let y_passDay = screenHight/2
        newDay.frame.origin.y = y_newDay
        passDay.frame.origin.y = y_passDay
        
    }
    
    //点击记录新的一天的按钮
    @IBAction func newDayClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ChooseTypeViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
        
    }
    //查看过去日记按钮点击事件
    @IBAction func passDayClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }

}


extension MainPageViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
