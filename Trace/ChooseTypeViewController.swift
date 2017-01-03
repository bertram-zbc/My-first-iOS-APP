//
//  ChooseTypeViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit
import Popover

class ChooseTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var videoButton: UIButton!

    @IBAction func PicEssay(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DicSetViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func video(_ sender: UIButton) {
        
        //Popover使用测试
        
        let b2Width = videoButton.frame.width
        let b2Heiht = videoButton.frame.height
        let b2X = videoButton.frame.origin.x
        let b2Y = videoButton.frame.origin.y
        
        let pX = b2X + b2Width/2
        let pY = b2Y + b2Heiht + 2

        let startPoint = CGPoint(x: pX, y: pY)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        //为UIView添加控件
//        let image1: UIButton = UIButton(frame: CGRect(x: 10, y: 20, width: 20, height: 20))
//        image1.setBackgroundImage(UIImage(named: "star"), for: .normal)
//        image1.addTarget(self, action: #selector(tap(_button:)), for: UIControlEvents.touchUpInside)
//        aView.addSubview(image1)
        
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 20, width: 60, height: 30))
        
        label.text = "还没写"
        aView.addSubview(label)
        
        let popover = Popover()
        popover.show(aView, point: startPoint)
    }
    
//    func tap(_button: UIButton){
//        print("click")
//        
//    }
    
    
    @IBAction func returnSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
