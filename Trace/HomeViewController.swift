//
//  HomeViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let homeX = UIScreen.main.bounds.width - 20 - homeButton.frame.width
        let homeY = 57 - homeButton.frame.height
        homeButton.frame.origin = CGPoint(x: homeX, y: homeY)
    }

    
    @IBOutlet var homeButton: UIButton!
    
    @IBAction func homeClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //同步按钮
    @IBAction func syncClick(_ sender: UIButton) {
        
        self.view.makeToast("正在后台同步")
        //TODO
    }
    
    //关于按钮
    @IBAction func aboutClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AboutViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    //反馈按钮
    @IBAction func feedbackClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "FeedBackViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    //注销，退回到登录界面
    @IBAction func logoutClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }

    @IBAction func swipeReturn(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

//设置转场动画代理
extension HomeViewController: UIViewControllerTransitioningDelegate{
    
    //present动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    //dismiss动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
