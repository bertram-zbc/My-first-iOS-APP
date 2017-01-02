//
//  DicSetViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/17.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

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
            print(filePath)
            
            do{
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            } catch{
                print("create dir error")
            }
        }
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyBoard.instantiateViewController(withIdentifier: "ContentInputViewController")
//        viewController.transitioningDelegate = self
//        self.present(viewController, animated: true, completion: nil)
        
        let vc = BSImagePickerViewController()
        
        //vc.maxNumberOfSelections = 6  //设置最大选择照片数量
        
        //图片选择器逻辑
        bs_presentImagePickerController(vc, animated: true, select: {
            (asset: PHAsset) -> Void in
            //选择某张照片时，不进行操作
        }, deselect: {(asset: PHAsset) -> Void in
            //取消选择某张照片，不进行操作
        }, cancel: {(assets: [PHAsset]) -> Void in
            //取消选择，删除之前创建的目录
            
            DispatchQueue.global().async {
                let fileManager = FileManager.default
                let mydir = documentPath + "/Trace/Document"
                let date:String = getDate()
                //遍历并查找今天的文件目录并删除
                //let urls:[String] = fileManager.subpaths(atPath: mydir)!
                let urls:[String] = try! fileManager.contentsOfDirectory(atPath: mydir)
                for i in 0..<urls.count{
                    if urls[i].contains(date){
                        do{
                            try fileManager.removeItem(atPath: mydir+"/"+urls[i])
                        }catch{
                            print("delete dir error")
                        }
                        break
                    }
                }
            }
            
            
        }, finish: {(assets: [PHAsset]) -> Void in
            //完成选择，将选中的照片复制到文件夹中
            DispatchQueue.global().async {
                let fileManager = FileManager.default
                let mydir = documentPath + "/Trace/Document"
                let date:String = getDate()
                //遍历查找今天到文件目录
                let urls:[String] = try! fileManager.contentsOfDirectory(atPath: mydir)
                for i in 0..<urls.count{
                    if urls[i].contains(date){
                        for j in 0..<assets.count{
                            //依次遍历图片数组并写入文件
                            let option = PHContentEditingInputRequestOptions()
                            option.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData)
                                -> Bool in
                                return true
                            }
                            assets[j].requestContentEditingInput(with: option, completionHandler: {
                                (contentEditingInput: PHContentEditingInput?,info: [AnyHashable: Any]) -> Void in
                                //获取选中图片的沙盒路径
                                if let url = contentEditingInput!.fullSizeImageURL{
                                    //读图片
                                    let fileHandler = try! FileHandle(forReadingFrom: url)
                                    let data = fileHandler.readDataToEndOfFile()
                                    //写图片
                                    let fileManager = FileManager.default
                                    let fileDir = mydir + "/" + urls[i] + "/image"
                                    do{ //创建保存图片目录
                                        try fileManager.createDirectory(atPath: fileDir, withIntermediateDirectories: true, attributes: nil)
                                    }catch{
                                        print("create dir error")
                                    }
                                    let filePath = fileDir + "/" + String(j) + ".png"
                                    let imageData: NSData = NSData(data: data)
                                    let success = imageData.write(toFile: filePath, atomically: true)
                                    print(success)
                                }
                            })
                        }
                        
                        break
                    }
                }
            }
            //跳转到ContentInputViewControlller
            let message:String = "已选择"+String(assets.count)+"张照片"
            print(message)
            //更新UI界面必须放到主线程，不然会有问题
            DispatchQueue.main.async {
                self.view.makeToast(message, duration: 1.0, position: ToastPosition.bottom)
            }
            //等待1秒后跳转
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0, execute: {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "ContentInputViewController")
                viewController.transitioningDelegate = self
                self.present(viewController, animated: true, completion: nil)
            })
            
            
        }, completion: nil)
        
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
