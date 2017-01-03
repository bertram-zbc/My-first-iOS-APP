//
//  SearchViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextFieldLeft()  //设置左视图
        setLabelText()
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let searchTextWidth = searchTextField.frame.width
        let searchTextHeight = searchTextField.frame.height
        
        searchTextField.frame = CGRect(x: 50, y: 63, width: searchTextWidth, height: searchTextHeight)
        searchButton.frame = CGRect(x: 70 + searchTextWidth, y: 63, width: searchButton.frame.width, height: searchButton.frame.height)
        
        let moreButtonWidth = tripMore.frame.width
        let moreButtonHeight = tripMore.frame.height
        let moreButtonX = UIScreen.main.bounds.width - 20 - moreButtonWidth
        
        let titleWidth = UIScreen.main.bounds.width - 70 - 20
        let titleHeight = trip1.frame.height
        
        tripTextField.frame.origin = CGPoint(x: 50, y: 131)
        //计算more按钮位置使得与Label下对齐
        let tripMoreY = 131 + tripTextField.frame.height - moreButtonHeight
        tripMore.frame.origin = CGPoint(x: moreButtonX, y: tripMoreY)
        
        trip1.frame = CGRect(x: 70, y: 169, width: titleWidth, height: titleHeight)
        trip2.frame = CGRect(x: 70, y: 201, width: titleWidth, height: titleHeight)
        
        
        essayTextField.frame.origin = CGPoint(x: 50, y: 227)
        let essayMoreY = 227 + essayTextField.frame.height - moreButtonHeight
        essayMore.frame.origin = CGPoint(x: moreButtonX, y: essayMoreY)
        essay1.frame = CGRect(x: 70, y: 265, width: titleWidth, height: titleHeight)
        essay2.frame = CGRect(x: 70, y: 297, width: titleWidth, height: titleHeight)
        
        lifeTextField.frame.origin = CGPoint(x: 50, y: 323)
        let lifeMoreY = 323 + lifeTextField.frame.height - moreButtonHeight
        lifeMore.frame.origin = CGPoint(x: moreButtonX, y: lifeMoreY)
        life1.frame = CGRect(x: 70, y: 361, width: titleWidth, height: titleHeight)
        life2.frame = CGRect(x: 70, y: 393, width: titleWidth, height: titleHeight)
        
        thinkTextField.frame.origin = CGPoint(x: 50, y: 419)
        let thinkMoreY = 419 + thinkTextField.frame.height - moreButtonHeight
        thinkMore.frame.origin = CGPoint(x: moreButtonX, y: thinkMoreY)
        think1.frame = CGRect(x: 70, y: 457, width: titleWidth, height: titleHeight)
        think2.frame = CGRect(x: 70, y: 489, width: titleWidth, height: titleHeight)
        
        complainTextField.frame.origin = CGPoint(x: 50, y: 515)
        let complainMoreY = 515 + complainTextField.frame.height - moreButtonHeight
        complainMore.frame.origin = CGPoint(x: moreButtonX, y: complainMoreY)
        complain1.frame = CGRect(x: 70, y: 553, width: titleWidth, height: titleHeight)
        complain2.frame = CGRect(x: 70, y: 585, width: titleWidth, height: titleHeight)
        
    }
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var tripTextField: UITextField!
    @IBOutlet var essayTextField: UITextField!
    @IBOutlet var lifeTextField: UITextField!
    @IBOutlet var thinkTextField: UITextField!
    @IBOutlet var complainTextField: UITextField!
    
    @IBOutlet var trip1: UIButton!
    @IBOutlet var trip2: UIButton!
    
    @IBOutlet var essay1: UIButton!
    @IBOutlet var essay2: UIButton!
    
    @IBOutlet var life1: UIButton!
    @IBOutlet var life2: UIButton!
    
    @IBOutlet var think1: UIButton!
    @IBOutlet var think2: UIButton!
    
    @IBOutlet var complain1: UIButton!
    @IBOutlet var complain2: UIButton!
    
    @IBOutlet var tripMore: UIButton!
    @IBOutlet var essayMore: UIButton!
    @IBOutlet var lifeMore: UIButton!
    @IBOutlet var thinkMore: UIButton!
    @IBOutlet var complainMore: UIButton!
    
    
    let showString: [String] = [
        "您还没有写过游记哟",
        "没有更多游记了",
        "您还没有写过随笔哟",
        "没有更多随笔了",
        "您还没有记录生活哟",
        "没有更多生活了",
        "您还没有写过感悟哟",
        "没有更多感悟了",
        "您还没有吐槽哟",
        "没有更多吐槽了"
    ]
    
    //处理点击事件
    @IBAction func titleClick(_ sender: UIButton) {
        
        let title = sender.currentTitle
        var isShowString : Bool = false
        for i in 0..<showString.count {
            if title == showString[i]{
                isShowString = true
                break
            }
        }
        //如果是showString中的内容则不操作
        if !isShowString {
            //获取文章日期
            let date = title?.components(separatedBy: "\t")[0]
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "SearchAfterViewController") as! SearchAfterViewController
            viewController.transitioningDelegate = self
            //将日期数据发送给SearchAfterViewController
            viewController.dateFrom = date!
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    
    //读取文件中相应标签的文章
    func setLabelText(){
        
        //trip1.setTitle("2016/12/25\t今天去了北京，测试要很长的字符串，我也不知道要说些什么，应该够长了吧", for: UIControlState.normal)
        
        var tripNum: Int = 0
        var essayNum: Int = 0
        var lifeNum: Int = 0
        var thinkNum: Int = 0
        var complainNum: Int = 0
        
        let fileManager = FileManager.default
        let mydir = documentPath + "/Trace/Document"
        let urls: [String] = try! fileManager.contentsOfDirectory(atPath: mydir)
        for i in 0..<urls.count {
            //当前这篇是游记
            if urls[i].contains("trip"){
                if tripNum < 2 {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let date = urls[i].components(separatedBy: "&")[0]
                    do {
                        let content = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                        
                        if tripNum == 0{
                            trip1.setTitle(date+"\t"+content, for: UIControlState.normal)
                        } else {
                            trip2.setTitle(date+"\t"+content, for: UIControlState.normal)
                        }
                        
                    } catch {
                        print("read file error")
                    }
                    tripNum += 1
                }
            }
            //当前这篇是随笔
            else if urls[i].contains("essay"){
                if essayNum < 2 {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let date = urls[i].components(separatedBy: "&")[0]
                    do {
                        let content = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                        
                        if essayNum == 0{
                            essay1.setTitle(date+"\t"+content, for: UIControlState.normal)
                        } else {
                            essay2.setTitle(date+"\t"+content, for: UIControlState.normal)
                        }
                        
                    } catch {
                        print("read file error")
                    }
                    essayNum += 1
                }
            }
            //当前这篇是生活
            else if urls[i].contains("life"){
                if lifeNum < 2 {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let date = urls[i].components(separatedBy: "&")[0]
                    do {
                        let content = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                        
                        if lifeNum == 0{
                            life1.setTitle(date+"\t"+content, for: UIControlState.normal)
                        } else {
                            life2.setTitle(date+"\t"+content, for: UIControlState.normal)
                        }
                        
                    } catch {
                        print("read file error")
                    }
                    lifeNum += 1
                }
            }
            //当前这篇是感悟
            else if urls[i].contains("think"){
                if thinkNum < 2 {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let date = urls[i].components(separatedBy: "&")[0]
                    do {
                        let content = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                        
                        if thinkNum == 0{
                            think1.setTitle(date+"\t"+content, for: UIControlState.normal)
                        } else {
                            think2.setTitle(date+"\t"+content, for: UIControlState.normal)
                        }
                        
                    } catch {
                        print("read file error")
                    }
                    thinkNum += 1
                }
            }
            //当前这篇是吐槽
            else if urls[i].contains("complain"){
                if complainNum < 2 {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let date = urls[i].components(separatedBy: "&")[0]
                    do {
                        let content = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                        
                        if complainNum == 0{
                            complain1.setTitle(date+"\t"+content, for: UIControlState.normal)
                        } else {
                            complain2.setTitle(date+"\t"+content, for: UIControlState.normal)
                        }
                        
                    } catch {
                        print("read file error")
                    }
                    complainNum += 1
                }
            }
            
            if tripNum == 0 {
                //暂时没有关于游记的文章
                trip1.setTitle(showString[0], for: UIControlState.normal)
                trip2.alpha = 0
            }
            
            if tripNum == 1 {
                trip2.setTitle(showString[1], for: UIControlState.normal)
            }
            
            if essayNum == 0 {
                essay1.setTitle(showString[2], for: UIControlState.normal)
                essay2.alpha = 0
            }
            
            if essayNum == 1 {
                essay2.setTitle(showString[3], for: UIControlState.normal)
            }
            
            if lifeNum == 0 {
                life1.setTitle(showString[4], for: UIControlState.normal)
                life2.alpha = 0
            }
            
            if lifeNum == 1 {
                life2.setTitle(showString[5], for: UIControlState.normal)
            }
        
            if thinkNum == 0 {
                think1.setTitle(showString[6], for: UIControlState.normal)
                think2.alpha = 0
            }
            
            if thinkNum == 1 {
                think2.setTitle(showString[7], for: UIControlState.normal)
            }
            
            if complainNum == 0 {
                complain1.setTitle(showString[8], for: UIControlState.normal)
                complain2.alpha = 0
            }
            
            if complainNum == 1 {
                complain2.setTitle(showString[9], for: UIControlState.normal)
            }
        }
        
    }
    
    
    
    
   
    
    func setTextFieldLeft(){
        //搜索框添加leftview
        let leftViewSearch = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        searchTextField.leftView = leftViewSearch
        searchTextField.leftViewMode = UITextFieldViewMode.always
        
        //游记
        let leftViewTrip = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftViewTrip.image = UIImage(named: "star")
        leftViewTrip.contentMode = UIViewContentMode.center
        tripTextField.leftView = leftViewTrip
        tripTextField.leftViewMode = UITextFieldViewMode.always
        //随笔
        let leftViewEssay = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftViewEssay.image = UIImage(named: "star")
        leftViewEssay.contentMode = UIViewContentMode.center
        essayTextField.leftView = leftViewEssay
        essayTextField.leftViewMode = UITextFieldViewMode.always
        //生活
        let leftViewLife = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftViewLife.image = UIImage(named: "star")
        leftViewLife.contentMode = UIViewContentMode.center
        lifeTextField.leftView = leftViewLife
        lifeTextField.leftViewMode = UITextFieldViewMode.always
        //感悟
        let leftViewThink = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftViewThink.image = UIImage(named: "star")
        leftViewThink.contentMode = UIViewContentMode.center
        thinkTextField.leftView = leftViewThink
        thinkTextField.leftViewMode = UITextFieldViewMode.always
        //吐槽
        let leftViewComplain = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftViewComplain.image = UIImage(named: "star")
        leftViewComplain.contentMode = UIViewContentMode.center
        complainTextField.leftView = leftViewComplain
        complainTextField.leftViewMode = UITextFieldViewMode.always
        
    }
    
    
    @IBAction func returnSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

//设置转场动画代理
extension SearchViewController: UIViewControllerTransitioningDelegate{
    
    //present动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    //dismiss动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
