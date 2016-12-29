//
//  DicSetViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/17.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit

class DicSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setImageInVisable()
    }
    
    var personal: String = "public"
    var weather: String = "cloudy"
    var mood: String = "good"
    var tag: String = "life"
    
    //红色选择框图片设置
    @IBOutlet var chooseImagePublic: UIImageView!
    @IBOutlet var chooseImagePrivate: UIImageView!
    @IBOutlet var chooseImageSunny: UIImageView!
    @IBOutlet var chooseImageCloudy: UIImageView!
    @IBOutlet var chooseImageRainy: UIImageView!
    @IBOutlet var chooseImageSnowy: UIImageView!
    @IBOutlet var chooseImageGoodMood: UIImageView!
    @IBOutlet var chooseImageNormalMood: UIImageView!
    @IBOutlet var chooseImageBadMood: UIImageView!
    @IBOutlet var chooseImageTrip: UIImageView!
    @IBOutlet var chooseImageEssay: UIImageView!
    @IBOutlet var chooseImageLife: UIImageView!
    @IBOutlet var chooseImageThink: UIImageView!
    @IBOutlet var chooseImageComplain: UIImageView!
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        //创建文件夹用于保存日记数据
        DispatchQueue.global().async {
            let fileManager = FileManager.default
            let mydir = documentPath + "/Trace/Document"
        
            let stringDate = getDate() //获取日期
            let fileDir = stringDate + "&" + self.personal + "&" + self.weather + "&" + self.mood + "&" + self.tag
            let filePath = mydir + "/" + fileDir
            //print(filePath)
            
            do{
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            } catch{
                print("create dir error")
            }
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ContentInputViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
        
        
    }

    
    func setImageInVisable(){
        chooseImagePrivate.alpha = 0
        //chooseImagePublic.alpha = 0
        chooseImageSunny.alpha = 0
        //chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
        //chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 0
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        //chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
    }

    @IBAction func privateClick(_ sender: UITapGestureRecognizer) {
        chooseImagePrivate.alpha = 1.0
        chooseImagePublic.alpha = 0
        personal = "private"
    }
    
    @IBAction func publicClick(_ sender: UITapGestureRecognizer) {
        chooseImagePublic.alpha = 1.0
        chooseImagePrivate.alpha = 0
        personal = "public"
    }
    
    @IBAction func sunnyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 1.0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
        weather = "sunny"
    }

    @IBAction func cloudyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 1.0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
        weather = "cloudy"
    }
    
    @IBAction func rainyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 1.0
        chooseImageSnowy.alpha = 0
        weather = "rainy"
    }
    
    @IBAction func snowyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 1.0
        weather = "snowy"
    }
    
    @IBAction func goodMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 1.0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 0
        mood = "good"
    }
    
    @IBAction func normalMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 1.0
        chooseImageBadMood.alpha = 0
        mood = "normal"
    }
    
    @IBAction func badMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 1.0
        mood = "bad"
    }
    
    @IBAction func tripClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 1.0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
        tag = "trip"
    }
    
    @IBAction func essayClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 1.0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
        tag = "essay"
    }
    
    @IBAction func lifeClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 1.0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
        tag = "life"
    }
    
    @IBAction func thinkClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 1.0
        chooseImageComplain.alpha = 0
        tag = "think"
    }
    
    @IBAction func complainClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 1.0
        tag = "complain"
    }
    
    
}


//设置转场动画代理
extension DicSetViewController: UIViewControllerTransitioningDelegate{
    
    //present动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    //dismiss动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
