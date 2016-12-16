//
//  ContentInputViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/15.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit

class ContentInputViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置字体
        text.font = UIFont.init(name: "HYWaiWaiTiJ", size: 17.0)
        //设置textview躲避键盘
        keyboard.avoid(inView: self.view, textView: text, offSetY: 0)

    }
    
    
    var keyboard = TextViewKeyBoard()
    @IBOutlet var text: UITextView!
    
    //触摸关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
