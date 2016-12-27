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

    @IBOutlet var searchTextField: UITextField!
    
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
    
    
    
    func setLabelText(){
        
        trip1.setTitle("2016/12/25\t今天去了北京，测试要很长的字符串，我也不知道要说些什么，应该够长了吧", for: UIControlState.normal)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
