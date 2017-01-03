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
    @IBOutlet var homeButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHight = UIScreen.main.bounds.height
        let buttonHight = newDay.frame.height
        let off:CGFloat = 50
        let y_newDay = screenHight/2 - off - buttonHight
        let y_passDay = screenHight/2
        newDay.frame.origin.y = y_newDay
        passDay.frame.origin.y = y_passDay
        
        let homeX = UIScreen.main.bounds.width - 20 - homeButton.frame.width
        let homeY = 57 - homeButton.frame.height
        homeButton.frame.origin = CGPoint(x: homeX, y: homeY)
    }
    
    //点击记录新的一天的按钮
    @IBAction func newDayClick(_ sender: UIButton) {
        
        let date:String = getDate()
        let fileManager = FileManager.default
        let mydir = documentPath + "/Trace/Document"
        let isDirExist = fileManager.fileExists(atPath: mydir)
        if isDirExist{
            //判断今天的日记是否已经写了
            print(mydir+"已存在")
            let urls:[String] = try! fileManager.contentsOfDirectory(atPath: mydir)
            var isWrite:Bool = false
            print(urls.count)
            for i in 0..<urls.count{
                print(urls[i])
                if urls[i].contains(date){
                    isWrite = true
                    break
                }
            }
            if isWrite{
                //已经写过了，跳转到其他viewcontroller
                //print("今天写过了")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "DictionaryViewController")
                viewController.transitioningDelegate = self
                self.present(viewController, animated: true, completion: nil)
                
            } else{
               //还没写过
                //print("今天还没写")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "ChooseTypeViewController")
                viewController.transitioningDelegate = self
                self.present(viewController, animated: true, completion: nil)
            }
            
        }else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ChooseTypeViewController")
            viewController.transitioningDelegate = self
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    //查看过去日记按钮点击事件
    @IBAction func passDayClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    //打开设置页面
    @IBAction func homeClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
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
